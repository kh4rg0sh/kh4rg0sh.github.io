import os
import re

DIR = "_codeforces"

for fname in os.listdir(DIR):
    if not fname.endswith(".md"):
        continue

    path = os.path.join(DIR, fname)
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()

    if not text.startswith("---"):
        continue

    # 1. Fix invalid rating
    text = re.sub(
        r"^rating:\s*\?$",
        "rating: null",
        text,
        flags=re.MULTILINE
    )

    # 2. Quote title safely
    def quote_title(match):
        title = match.group(1).strip()
        title = title.replace('"', '\\"')
        return 'title: "{}"'.format(title)

    text = re.sub(
        r"^title:\s*(.+)$",
        quote_title,
        text,
        flags=re.MULTILINE
    )

    # 3. Quote index (A, B, C...)
    text = re.sub(
        r"^index:\s*(.+)$",
        r'index: "\1"',
        text,
        flags=re.MULTILINE
    )

    with open(path, "w", encoding="utf-8") as f:
        f.write(text)

print("YAML repair done.")
