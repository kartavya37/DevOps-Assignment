#!/usr/bin/env python3
"""Security gate for the Session 21 final project pipeline.

The scan jobs (SAST, SCA, IaC, secret scan, image scans) always write a JSON report.
This script reads all reports and applies one policy. It exits with code 1 if the
policy blocks the release. Then GitHub Actions stops the pipeline before
"Push Images" and "Deploy to Kubernetes".

Policy:
  SAST     Bandit                  block on HIGH severity issues
  SCA      pip-audit (backend)     block on a known vulnerability that has a fixed version
  SCA      npm audit (frontend)    block on HIGH or CRITICAL
  SCA      Trivy fs (application)  block on HIGH or CRITICAL
  IaC      Trivy config            block on HIGH or CRITICAL misconfigurations (accepted IDs in .trivyignore)
  Secrets  Gitleaks                block on any finding
  Images   Trivy image (x2)        block on HIGH or CRITICAL (fixed versions only, --ignore-unfixed)
  A missing or unreadable report also blocks (fail closed).

Usage: python security/security_gate.py <reports-dir>
Only the Python standard library is used.
"""
import json
import os
import sys
from pathlib import Path

BLOCK_SEVERITIES = {"HIGH", "CRITICAL"}
MAX_LINES = 6  # blocking findings printed per tool; the JSON report has all of them


def load(path):
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


def check_bandit(data):
    results = data.get("results", [])
    blocking = [r for r in results if r.get("issue_severity") == "HIGH"]
    lines = [
        f"{r['test_id']} {r['issue_severity']}: {r['issue_text']} ({r['filename']}:{r['line_number']})"
        for r in blocking
    ]
    return len(results), lines


def check_pip_audit(data):
    deps = data.get("dependencies", data) if isinstance(data, dict) else data
    seen, lines = set(), []
    for dep in deps:
        for vuln in dep.get("vulns", []):
            key = (dep["name"], dep.get("version"), vuln["id"])
            if key in seen:  # pip-audit can list the same package twice
                continue
            seen.add(key)
            if vuln.get("fix_versions"):
                lines.append(f"{dep['name']} {dep.get('version')}: {vuln['id']} (fix: {', '.join(vuln['fix_versions'])})")
    return len(seen), lines


def check_npm_audit(data):
    vulns = data.get("vulnerabilities", {}) or {}
    lines = [
        f"{name}: {info.get('severity', '?').upper()} (range {info.get('range', '?')})"
        for name, info in sorted(vulns.items())
        if str(info.get("severity", "")).upper() in BLOCK_SEVERITIES
    ]
    return len(vulns), lines


def check_trivy(data):
    total, lines = 0, []
    for result in data.get("Results", []) or []:
        for vuln in result.get("Vulnerabilities", []) or []:
            total += 1
            if vuln.get("Severity") in BLOCK_SEVERITIES:
                lines.append(
                    f"{vuln['PkgName']} {vuln.get('InstalledVersion', '?')}: {vuln['VulnerabilityID']} "
                    f"{vuln['Severity']} (fix: {vuln.get('FixedVersion') or 'none'})"
                )
        for secret in result.get("Secrets", []) or []:
            total += 1
            if secret.get("Severity") in BLOCK_SEVERITIES:
                lines.append(f"secret {secret.get('RuleID')} in {result.get('Target')}")
    return total, lines


def check_trivy_config(data):
    total, lines = 0, []
    for result in data.get("Results", []) or []:
        for item in result.get("Misconfigurations", []) or []:
            if item.get("Status") != "FAIL":
                continue
            total += 1
            if item.get("Severity") in BLOCK_SEVERITIES:
                lines.append(f"{result.get('Target')}: {item.get('ID')} {item.get('Severity')} {item.get('Title')}")
    return total, lines


def check_gitleaks(data):
    findings = data or []
    lines = [f"{f.get('RuleID')} in {f.get('File')}:{f.get('StartLine')}" for f in findings]
    return len(findings), lines


CHECKS = [
    ("SAST", "Bandit", "bandit.json", check_bandit),
    ("SCA", "pip-audit", "pip-audit.json", check_pip_audit),
    ("SCA", "npm audit", "npm-audit.json", check_npm_audit),
    ("SCA", "Trivy fs", "trivy-fs.json", check_trivy),
    ("IaC", "Trivy config", "trivy-config.json", check_trivy_config),
    ("Secret scan", "Gitleaks", "gitleaks.json", check_gitleaks),
    ("Image scan", "Trivy backend", "trivy-image-backend.json", check_trivy),
    ("Image scan", "Trivy frontend", "trivy-image-frontend.json", check_trivy),
]


def main():
    reports = Path(sys.argv[1] if len(sys.argv) > 1 else "reports")
    rows, details, blocked = [], [], False

    for stage, tool, filename, check in CHECKS:
        path = reports / filename
        try:
            total, blocking = check(load(path))
        except (OSError, ValueError, KeyError, TypeError, AttributeError) as err:
            rows.append((stage, tool, "-", "-", "FAIL (report missing or invalid)"))
            details.append(f"[{tool}] cannot read {path}: {err}")
            blocked = True
            continue
        verdict = "FAIL" if blocking else "PASS"
        blocked = blocked or bool(blocking)
        rows.append((stage, tool, str(total), str(len(blocking)), verdict))
        details.extend(f"[{tool}] {line}" for line in blocking[:MAX_LINES])
        if len(blocking) > MAX_LINES:
            details.append(f"[{tool}] ... and {len(blocking) - MAX_LINES} more (see {filename})")

    header = ("Stage", "Tool", "Findings", "Blocking", "Result")
    widths = [max(len(r[i]) for r in rows + [header]) for i in range(5)]

    def fmt(row):
        return "  ".join(cell.ljust(widths[i]) for i, cell in enumerate(row))

    print("=" * 66)
    print("SECURITY GATE (block on HIGH/CRITICAL, any secret, fail closed)")
    print("=" * 66)
    print(fmt(header))
    print(fmt(tuple("-" * w for w in widths)))
    for row in rows:
        print(fmt(row))
    if details:
        print("\nBlocking findings:")
        for line in details:
            print(f"  - {line}")
    decision = "FAILED: the pipeline stops here. Fix the findings above." if blocked else \
        "PASSED: the images can be pushed and deployed."
    print(f"\nSecurity gate {decision}")

    summary = os.getenv("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as out:
            out.write("### Security gate\n\n| " + " | ".join(header) + " |\n|" + "---|" * 5 + "\n")
            for row in rows:
                out.write("| " + " | ".join(row) + " |\n")
            out.write(f"\n**Security gate {decision}**\n")
            for line in details:
                out.write(f"- {line}\n")

    return 1 if blocked else 0


if __name__ == "__main__":
    sys.exit(main())
