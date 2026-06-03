#!/usr/bin/env python3
import argparse
import os
import shutil
import subprocess
import sys

TEMPLATE_FILE = "template.rb"
INPUT_FILE = "input.txt"


def create_ruby_file(name: str) -> str:
    if not name.endswith(".rb"):
        name = f"{name}.rb"

    if not os.path.exists(TEMPLATE_FILE):
        raise FileNotFoundError(f"Template file not found: {TEMPLATE_FILE}")

    if os.path.exists(name):
        print(f"{name} already exists. Opening it in the editor...")
    else:
        with open(TEMPLATE_FILE, "r", encoding="utf-8") as src:
            content = src.read()
        with open(name, "w", encoding="utf-8") as dst:
            dst.write(content)
        print(f"Created {name} from {TEMPLATE_FILE}.")

    open_in_editor(name)
    return name


def open_in_editor(path: str) -> None:
    code_cmd = shutil.which("code")
    if code_cmd:
        subprocess.run([code_cmd, path], check=False)
        return

    xdg_cmd = shutil.which("xdg-open")
    if xdg_cmd:
        subprocess.run([xdg_cmd, path], check=False)
        return

    if os.name == "posix":
        print(f"Could not open the file automatically. Open {path} in your editor manually.")
    else:
        print(f"Open {path} in your editor.")


def solve_ruby_file(name: str) -> None:
    if not name.endswith(".rb"):
        name = f"{name}.rb"

    if not os.path.exists(name):
        raise FileNotFoundError(f"Ruby file not found: {name}")
    if not os.path.exists(INPUT_FILE):
        raise FileNotFoundError(f"Input file not found: {INPUT_FILE}")

    with open(INPUT_FILE, "rb") as stdin_file:
        process = subprocess.run(
            ["ruby", name],
            stdin=stdin_file,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=False,
        )

    sys.stdout.buffer.write(process.stdout)
    if process.returncode != 0:
        sys.stderr.buffer.write(process.stderr)
        sys.exit(process.returncode)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create or run a Ruby contest file from template.rb."
    )
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        "--create",
        metavar="NAME",
        help="create NAME.rb from template.rb and open it in the editor",
    )
    group.add_argument(
        "--solve",
        metavar="NAME",
        help="execute ruby NAME.rb < input.txt and print the output",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if args.create:
        create_ruby_file(args.create)
    elif args.solve:
        solve_ruby_file(args.solve)


if __name__ == "__main__":
    main()
