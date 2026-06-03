#!/usr/bin/env python3
"""Sync Codeforces problemset metadata into _codeforces/*.md for Jekyll."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

import requests

API_URL = "https://codeforces.com/api/problemset.problems"
REPO_ROOT = Path(__file__).resolve().parents[2]
CODEFORCES_DIR = REPO_ROOT / "_codeforces"


def fetch_problems() -> list[dict]:
    response = requests.get(API_URL, timeout=60)
    response.raise_for_status()
    payload = response.json()
    if payload.get("status") != "OK":
        raise RuntimeError(f"Codeforces API error: {payload.get('comment', payload)}")
    return payload["result"]["problems"]


def problem_filename(problem: dict) -> str:
    return f'{problem["contestId"]}{problem["index"]}.md'


def read_existing(path: Path) -> tuple[bool, str]:
    if not path.exists():
        return False, ""

    text = path.read_text(encoding="utf-8")
    if not text.startswith("---"):
        return False, text

    parts = text.split("---", 2)
    if len(parts) < 3:
        return False, text

    front_matter = parts[1]
    body = parts[2]
    solved = "solved: true" in front_matter
    return solved, body


def render_markdown(problem: dict, *, solved: bool, body: str) -> str:
    title = json.dumps(problem["name"])
    index = json.dumps(str(problem["index"]))
    rating = problem.get("rating")
    rating_line = f"rating: {rating}" if rating is not None else "rating: null"
    tags = repr(problem.get("tags") or [])

    lines = [
        "---",
        "layout: page",
        f"title: {title}",
        f"contest: {problem['contestId']}",
        f"index: {index}",
        rating_line,
        f"tags: {tags}",
    ]
    if solved:
        lines.append("solved: true")
    lines.extend(["---", ""])

    content = "\n".join(lines)
    if body:
        if not body.startswith("\n"):
            content += "\n"
        content += body
        if not content.endswith("\n"):
            content += "\n"
    return content


def sync_problems(*, dry_run: bool = False) -> tuple[int, int, int]:
    problems = fetch_problems()
    CODEFORCES_DIR.mkdir(parents=True, exist_ok=True)

    created = 0
    updated = 0
    unchanged = 0

    for problem in problems:
        path = CODEFORCES_DIR / problem_filename(problem)
        solved, body = read_existing(path)
        content = render_markdown(problem, solved=solved, body=body)

        if path.exists():
            if path.read_text(encoding="utf-8") == content:
                unchanged += 1
                continue
            updated += 1
            action = "update"
        else:
            created += 1
            action = "create"

        if dry_run:
            print(f"[dry-run] would {action}: {path.name}")
            continue

        path.write_text(content, encoding="utf-8")

    return created, updated, unchanged


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create or update _codeforces markdown files from the Codeforces API."
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="show what would change without writing files",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    try:
        created, updated, unchanged = sync_problems(dry_run=args.dry_run)
    except requests.RequestException as exc:
        print(f"Failed to fetch problems: {exc}", file=sys.stderr)
        sys.exit(1)
    except RuntimeError as exc:
        print(exc, file=sys.stderr)
        sys.exit(1)

    prefix = "Would sync" if args.dry_run else "Synced"
    print(
        f"{prefix} {created + updated + unchanged} problems "
        f"({created} created, {updated} updated, {unchanged} unchanged)"
    )


if __name__ == "__main__":
    main()
