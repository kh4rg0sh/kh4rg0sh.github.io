#!/usr/bin/env python3

import sys
import json
import time
import random
import datetime

# db entries format
# problem code | timestamp | # times reviewed | next time to review

review_time = [
    12 * 60 * 60,
    24 * 60 * 60,
    3 * 24 * 60 * 60,
    7 * 24 * 60 * 60,
    21 * 24 * 60 * 60,
    60 * 24 * 60 * 60
]

def print_help() -> None:
    print("CP Trainer Tool - Spaced Repetition for Competitive Programming\n")
    print("Usage:")
    print("  cptool queue <problem_code>   Add a problem to the review schedule")
    print("  cptool review                 List problems ready to review")
    print("  cptool list                   List all tracked problems")
    print("  cptool upsolve <problem_code> Mark a problem as reviewed and schedule next review")
    print("  cptool help                   Show this help message")
    print("  cptool progress               Show review progress for all problems")
    print("  cptool suggest                Suggest a problem to review now\n")
    print("Example:")
    print("  cptool queue CF-1900A")
    print("  cptool review")

def load_db() -> dict:
    try:
        with open("db.json", "r") as f:
            data = f.read().strip()
            if not data:
                return {}
            return json.loads(data)
    except FileNotFoundError:
        return {}

def to_review(problem_code: str) -> bool:
    db = load_db()

    if problem_code not in db:
        print("[!] Problem not found in database.")
        exit(1)
        return False
   
    current_time = time.time()
    next_review_time = db[problem_code]["review_time"]

    return current_time >= next_review_time

def all_problems() -> list[str]:
    db = load_db()

    problem_list: list[str] = []
    for entry_code, information in db.items():
        problem_list.append(entry_code)

    return problem_list

def list_problems() -> list[str]:
    db = load_db()

    problem_list: list[str] = []
    for entry_code, information in db.items():
        current_time = time.time()
        next_review_time = information["review_time"]

        if current_time >= next_review_time:
            problem_list.append(entry_code)

    return problem_list

def suggest_problem() -> None:
    problems = list_problems()

    if not problems:
        print("[*] No problems ready for review.")
        return

    suggestion = random.choice(problems)
    print("[*] Suggested problem to review:")
    print(suggestion)

def add_problem(problem_code: str) -> None:
    db = load_db()
    if problem_code in db:
        print("[!] Problem already exists in the database!")
        return

    current_time = time.time()
    times_reviewed = 0
    offset_time = review_time[times_reviewed]
    db[problem_code] = {
        "added_time": current_time,
        "times_reviewed": times_reviewed,
        "review_time": current_time + offset_time
    }

    utc_time = datetime.datetime.fromtimestamp(current_time, datetime.timezone.utc)
    print(f"[+] Problem entry created in the database\n- Added {problem_code} at {utc_time.strftime('%Y-%m-%d %H:%M:%S UTC')}")

    with open("db.json", "w") as f:
        json.dump(db, f, indent=2)
    return

def update_problem(problem_code: str) -> None:
    db = load_db()
    if problem_code not in db:
        print("[!] Problem not found in database.")
        return

    added_time = db[problem_code]["added_time"]
    current_time = time.time()
    times_reviewed = db[problem_code]["times_reviewed"] + 1
    if times_reviewed < 6:
        offset_time = review_time[times_reviewed]
        db[problem_code] = {
            "added_time": added_time,
            "times_reviewed": times_reviewed,
            "review_time": current_time + offset_time
        }

        utc_time = datetime.datetime.fromtimestamp(current_time, datetime.timezone.utc)
        print(f"[+] Problem reviewed\n- {problem_code} at {utc_time}")

        with open("db.json", "w") as f:
            json.dump(db, f, indent=2)
        return
    else:
        print("[!] Problem completed all review stages!")
        return
    
def progress() -> None:
    db = load_db()
    if not db:
        print("[*] No problems in the database.")
        return

    print(f"{'Problem Code':<15} {'Reviews':<8} {'Next Review'}")
    print("-" * 45)

    for code, info in db.items():
        reviews = f"{info['times_reviewed']}/6"

        next_time = datetime.datetime.fromtimestamp(
            info["review_time"],
            datetime.timezone.utc
        ).strftime("%Y-%m-%d %H:%M")

        print(f"{code:<15} {reviews:<8} {next_time}")

if len(sys.argv) == 1:
    print_help()
    sys.exit()

if len(sys.argv) > 1:
    if sys.argv[1] == "queue":
        if len(sys.argv) != 3:
            print("[!] Error: usage is \"cptool queue <problem code>\"")
        
        else:
            # open the file db and write this entry over there, taking the current time
            problem_code = sys.argv[2]
            add_problem(problem_code)
    
    elif sys.argv[1] == "review":
        if len(sys.argv) != 2:
            print("[!] Error: usage is \"cptool review\"")
        
        else:
            # load the db file, pick only the problems that have next_time_to_review <= current_time
            problems = list_problems()
            if not problems:
                print("[*] No problems scheduled for review.")
            else:
                print("[*] Problems to review today:")
                for indx, problem in enumerate(problems, start = 1):
                    print(f"{indx}. {problem}")

    elif sys.argv[1] == "list":
        if len(sys.argv) != 2:
            print("[!] Error: usage is \"cptool list\"")

        else:
            # load the db file and print all the problems
            print("[*] Problems in the database:")
            problems = all_problems()
            for indx, problem in enumerate(problems, start = 1):
                print(f"{indx}. {problem}")

    elif sys.argv[1] == "upsolve":
        if len(sys.argv) != 3:
            print("[!] Error: usage is \"cptool upsolve <problem code>\"")
        
        else:
            # sanity check to see if the problem to be upsolved is in cp list?
            problem_code = sys.argv[2]
            if not to_review(problem_code):
                print(f"[!] Error: problem {problem_code} not scheduled to be reviewed yet!")

            else:
                # update the db entry
                # update the time stamp, and increment the times reviewed and schedule the next time to review
                update_problem(problem_code)

    elif sys.argv[1] == "progress":
        if len(sys.argv) != 2:
            print("[!] Error: usage is \"cptool progress\"")
        else:
            progress()
    
    elif sys.argv[1] == "suggest":
        if len(sys.argv) != 2:
            print("[!] Error: usage is \"cptool suggest\"")
        else:
            suggest_problem()

    elif sys.argv[1] == "help":
        print_help()
    
    else:
        print("[!] Unknown command")
        print_help()
                

