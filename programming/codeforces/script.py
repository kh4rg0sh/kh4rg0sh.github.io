import requests
from bs4 import BeautifulSoup
import re
import time

HEADERS = {"User-Agent": "Mozilla/5.0"}

BASE = "https://codeforces.com"

# 1) get problem list
# url = "https://codeforces.com/problemset?tags=shortest%20paths,1900-1900"
url = "https://codeforces.com/api/problemset.problems?tags=shortest%20paths"
html = requests.get(url, headers=HEADERS).text

import json 
response = json.loads(html)

problems = []
for problem in response["result"]["problems"]:
    code = str(problem["contestId"]) + problem["index"]
    problems.append(code)

print(problems)

# problems = []
# for a in soup.select("a[href^='/problemset/problem/']"):
#     m = re.search(r'/problemset/problem/(\d+)/([A-Z]\d*)', a["href"])
#     if m:
#         contest, index = m.groups()
#         problems.append(f"{contest}{index}")

# problems = list(set(problems))
# print("Found problems:", problems)

# 2) function to find editorial via Google (cheap trick)
# def find_editorial(problem_code):
#     q = f"Codeforces {problem_code} editorial"
#     google = f"https://www.google.com/search?q={q.replace(' ', '+')}"
#     html = requests.get(google, headers=HEADERS).text
#     print(html)
#     m = re.search(r'codeforces\.com/blog/entry/\d+', html)
#     return m.group(0) if m else None

# # 3) check for keyword
# good = []
# for p in problems:
#     print("Checking", p)
#     blog = find_editorial(p)
#     if not blog:
#         continue

#     print("found blog: ", blog)
    
#     html = requests.get("https://" + blog, headers=HEADERS).text.lower()
#     if "dijkstra" in html:
#         good.append(p)
#         print("  -> FOUND DIJKSTRA")

#     time.sleep(2)  # be polite

# print("RESULT:", good)
