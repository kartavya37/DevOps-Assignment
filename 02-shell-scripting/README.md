# Shell Scripting: system information script

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

[`sysinfo.sh`](sysinfo.sh) prints the date, hostname, user, disk usage and the running
processes, then asks where to save a report and writes the full process list into that file.

## The script

```bash
#!/bin/bash
# sysinfo.sh - prints basic system info, then saves a snapshot of running processes.
# DevOps homework, shell scripting task.

current_date=$(date)
host_name=$(hostname)
user_name=$(whoami)

echo "=========================================="
echo "         SYSTEM INFORMATION REPORT        "
echo "=========================================="
echo "Date and time : $current_date"
echo "Hostname      : $host_name"
echo "Logged in as  : $user_name"
echo

echo "----- Disk usage (df -h) -----"
df -h
echo

echo "----- Running processes (top 10 by CPU) -----"
ps aux | head -11
echo

read -p "Name the folder where the report should be saved: " report_dir
read -p "Name the file for the process snapshot: " report_file

mkdir -p "$report_dir"
touch "$report_dir/$report_file"

# the full list goes to the file, not just the 10 shown above
ps aux > "$report_dir/$report_file"

echo
echo "Saved the process list to: $report_dir/$report_file"
echo "Lines written: $(wc -l < "$report_dir/$report_file")"
echo "=========================================="
```

## Running it

```bash
chmod +x sysinfo.sh
./sysinfo.sh
```

`chmod +x` is what makes it runnable on its own. Without it you'd have to say `bash sysinfo.sh`.

## Output

I answered the two prompts with `system-report` and `processes.txt`.

```console
==========================================
         SYSTEM INFORMATION REPORT        
==========================================
Date and time : Thu Sep  3 21:20:45 IST 2026
Hostname      : Kartavyas-MacBook-Pro.local
Logged in as  : kp

----- Disk usage (df -h) -----
Filesystem        Size    Used   Avail Capacity iused ifree %iused  Mounted on
/dev/disk3s1s1   926Gi    15Gi   628Gi     3%    459k  4.3G    0%   /
devfs            223Ki   223Ki     0Bi   100%     770     0  100%   /dev
/dev/disk3s6     926Gi    15Gi   628Gi     3%      15  6.6G    0%   /System/Volumes/VM
/dev/disk3s2     926Gi    17Gi   628Gi     3%    1.5k  6.6G    0%   /System/Volumes/Preboot
/dev/disk3s4     926Gi   870Mi   628Gi     1%     539  6.6G    0%   /System/Volumes/Update
/dev/disk1s2     550Mi   6.0Mi   530Mi     2%       1  5.4M    0%   /System/Volumes/xarts
/dev/disk1s1     550Mi   5.8Mi   530Mi     2%      40  5.4M    0%   /System/Volumes/iSCPreboot
/dev/disk1s3     550Mi   3.0Mi   530Mi     1%     115  5.4M    0%   /System/Volumes/Hardware
/dev/disk3s5     926Gi   247Gi   628Gi    29%    1.6M  6.6G    0%   /System/Volumes/Data
map auto_home      0Bi     0Bi     0Bi   100%       0     0     -   /System/Volumes/Data/home
/dev/disk4s3     1.4Gi   718Mi   761Mi    49%     705  4.3G    0%   /Volumes/Google Chrome
/dev/disk5s1     1.0Gi   926Mi    80Mi    93%    3.6k  4.3G    0%   /Volumes/VS Code
/dev/disk2s1     5.0Gi   1.3Gi   3.7Gi    26%      50   39M    0%   /System/Volumes/Update/SFR/mnt1
/dev/disk7s1     812Mi   726Mi    83Mi    90%    1.0k  855k    0%   /Volumes/Brave Browser
/dev/disk8s1     163Mi   161Mi   2.3Mi    99%    1.8k  4.3G    0%   /Volumes/VLC media player
/dev/disk9s2     2.3Gi   2.1Gi   171Mi    93%     274  4.3G    0%   /private/var/folders/jn/jt17j5vx3fz4fng1bw8zmq980000gn/T/com.docker.install/DockerDesktop-237115
/dev/disk3s1     926Gi    15Gi   628Gi     3%    459k  4.3G    0%   /System/Volumes/Update/mnt1

----- Running processes (top 10 by CPU) -----
USER               PID  %CPU %MEM      VSZ    RSS   TT  STAT STARTED      TIME COMMAND
root             78753  35.5  0.1 435399952  34496   ??  Ss    7:19PM   0:55.03 /System/Library/PrivateFrameworks/XprotectFramework.framework/Versions/A/XPCServices/XprotectService.xpc/Contents/MacOS/XprotectService
kp                1062   4.2  0.1 435409360  17040   ??  S    19Aug26  16:09.90 /usr/libexec/rapportd
root               170   3.3  0.1 435496480  15744   ??  Ss   19Aug26  10:35.50 /usr/libexec/syspolicyd
kp                1343   3.0  0.2 436084384  41072   ??  S    19Aug26  35:07.31 /usr/libexec/sharingd
_trustd          29780   2.4  0.0 435410352  10432   ??  Ss   21Aug26   3:24.28 /usr/libexec/trustd
kp               86511   2.0  1.1 440995200 266160   ??  S     8:02PM   0:14.10 /Users/kp/.vscode/extensions/anthropic.claude-code-2.1.259-darwin-arm64/resources/native-binary/claude --output-format stream-json --verbose --input-format stream-json --max-thinking-tokens 31999 --permission-prompt-tool stdio --setting-sources=user,project,local --permission-mode auto --include-partial-messages --debug --debug-to-stderr --enable-auth-status --no-chrome --replay-user-messages
kp               15931   2.0  0.0 435299488   2080   ??  S     9:20PM   0:00.01 /bin/bash ./sysinfo.sh
kp               14778   2.0  0.8 440990016 192624   ??  S     4:17PM   2:08.55 /Users/kp/.vscode/extensions/anthropic.claude-code-2.1.258-darwin-arm64/resources/native-binary/claude --output-format stream-json --verbose --input-format stream-json --max-thinking-tokens 31999 --permission-prompt-tool stdio --setting-sources=user,project,local --permission-mode auto --include-partial-messages --debug --debug-to-stderr --enable-auth-status --no-chrome --replay-user-messages
kp               74330   1.7  4.3 443752912 1078256   ??  Ss    5:43PM  17:29.75 /System/Library/Frameworks/Virtualization.framework/Versions/A/XPCServices/com.apple.Virtualization.VirtualMachine.xpc/Contents/MacOS/com.apple.Virtualization.VirtualMachine
_driverkit         241   1.5  0.2 435325536  48896   ??  Ss   19Aug26 155:36.58 /System/Library/DriverExtensions/AppleCentauriAlpha.dext/AppleCentauriAlpha com.apple.driver.AppleCentauriAlpha 0x100001221 com.apple.driver.AppleCentauriAlpha


Saved the process list to: system-report/processes.txt
Lines written:      703
==========================================
```

## What it left behind

```console
$ ls -R
sysinfo.sh    run-output.txt    system-report/

system-report:
processes.txt

$ wc -l system-report/processes.txt
     703 system-report/processes.txt

$ head -4 system-report/processes.txt
USER               PID  %CPU %MEM      VSZ    RSS   TT  STAT STARTED      TIME COMMAND
root             78753  35.5  0.1 435399952  34496   ??  Ss    7:19PM   0:55.03 /System/Library/PrivateFrameworks/XprotectFramework.framework/Versions/A/XPCServices/XprotectService.xpc/Contents/MacOS/XprotectService
kp                1062   4.2  0.1 435409360  17040   ??  S    19Aug26  16:09.90 /usr/libexec/rapportd
root               170   3.3  0.1 435496480  15744   ??  Ss   19Aug26  10:35.50 /usr/libexec/syspolicyd
```

The terminal only showed 10 processes because of `head -11`, but the file has all 703 of them.
The redirect gets the full `ps aux` output, the `head` only affects what was printed.

## Notes

`$(...)` runs a command and hands back what it printed, so `current_date=$(date)` stores the
date as text. Backticks do the same thing but nest badly, so `$(...)` is the one to use.

`read -p` prints the prompt and reads the answer in one step, instead of an `echo` followed by
a bare `read`.

The quotes in `"$report_dir/$report_file"` matter more than they look. Without them, a folder
name with a space in it gets split into two arguments and `mkdir` quietly creates two
directories instead of one.

`mkdir -p` doesn't fail when the directory already exists, so I can run the script twice.
Plain `mkdir` errors out the second time.

`touch` makes the empty file and `ps aux > file` fills it. `>` overwrites on every run,
`>>` would append instead.
