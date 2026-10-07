"""Calculator functions. The CI pipeline tests these functions with pytest."""
import re


def add(a, b):
    return a + b


def subtract(a, b):
    return a - b


def multiply(a, b):
    return a * b


def divide(a, b):
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b


OPERATIONS = {
    "add": add,
    "subtract": subtract,
    "multiply": multiply,
    "divide": divide,
}


def calculate(operation, a, b):
    """Run one operation by name. Raise ValueError for an unknown name."""
    if operation not in OPERATIONS:
        raise ValueError(f"Unknown operation '{operation}'. Valid: {sorted(OPERATIONS)}")
    return OPERATIONS[operation](a, b)


def main():
    """Interactive command-line calculator (the original class demo)."""
    symbols = {"+": "add", "-": "subtract", "*": "multiply", "/": "divide"}
    print("Calculator Application")
    print("Type 'q' to exit.")
    while True:
        expr = input("\nEnter calculation (e.g., 10 + 5): ")
        if expr.lower() in ("q", "quit"):
            break
        match = re.match(r"^\s*([\d\.]+)\s*([\+\-\*\/])\s*([\d\.]+)\s*$", expr)
        if not match:
            print("Invalid format. Use: number operator number")
            continue
        a, op, b = float(match.group(1)), match.group(2), float(match.group(3))
        try:
            print(f"Result: {calculate(symbols[op], a, b)}")
        except ValueError as err:
            print(f"Error: {err}")


if __name__ == "__main__":
    main()
