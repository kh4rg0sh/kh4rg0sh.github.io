import requests, os

problems = requests.get(
    "https://codeforces.com/api/problemset.problems"
).json()["result"]["problems"]

os.makedirs("_codeforces", exist_ok=True)

for p in problems:
    name = f'{p["contestId"]}{p["index"]}.md'
    with open(f"_codeforces/{name}", "w") as f:
        f.write(f"""---
layout: page
title: {p["name"]}
contest: {p["contestId"]}
index: {p["index"]}
rating: {p.get("rating", "?" )}
tags: {p.get("tags", [])}
---

""")
