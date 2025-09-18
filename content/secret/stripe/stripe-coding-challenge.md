---
title: Stripe Coding Challenge Experience [Round 1]
math: true
---

The first round in Stripe's recruitment process. This is a coding round. You will be given 60 minutes to code and submit the solution. The problem is an implementation-heavy problem. They don't usually test complex algorithmitc knowledge through these coding challenges. It's usually about being able to read lengthy problem descriptions and being able to understand and implement what is written.

# Starting the Test
With all the anxiety bundled within me, I begin the test. The plan was to read the problem description thoroughly for the first 5 to 10 minutes (as Stripe challenges are known for being notoriously implementation heavy). I had already made up my mind to attempt this challenge in Python, so I immediately switched the language and started reading the problem.

## Problem Description
Oh my fucking god. The problem statement was so long. My eyes felt tired and sleepy looking at the length of the statement. I could keep scrolling down to the page and it wouldn't take me to the bottom of the page. Anyway,

The problem was based on developing an algorithm for fraud detection. They split it into three parts. Each part was a continuation (a sort of development onto the previous parts). However, the testcases would cover all the three parts so you had to implement an algorithm that would work for all the three parts.

Now getting to what did they yap so much in there? As much as I could recall on top of my head:

### Part 1
You are given a list of fraud codes and non-fraud codes. Followed by that, you will be given the fraud payments threshold for each account type. Then you will be given a few accounts and their account type. So for each account, you know the fraud payments threshold for it. There if also a minimum amount of payments threshold to consider any account for fraud. So if the threshold is $x$, then there should be atleast $x$ payments from the account, and only then it would be okay to consider it for fraud processing.

Finally, you will be given a list of payments/transactions. Each of these payments has the account id, the amount and the payment code.

You have to finally report those accounts that should be marked as fraud.

### Part 2
This part modifies the fraud threshold from discrete threshold to a probabilistic threshold. So now if the threshold is a fraction $p/q$, then if at any point we observe that the ratio of fraud payments to total payments for an account crosses the threshold, we will mark that account as fraud even if later on this ratio goes below the threshold.

### Part 3
Additionally, the user is able to mark their selected payments as incorrectly flagged if it throws a fraud payment status code. 

if the fraud ratio goes below the probabilistic threshold any time such flag is reported, the fraud marked account should be unmarked.

The task still remains the same. You have to report those accounts that should be finally marked as fraud.

## My Attempt
Annoying parts first. each of these lists are given to you as an entire comma separated string. so you have to pre-process each data field in a way that it's usable. 

i created the useful data structures for business logic and parsed the input strings into this data:

```python
def solve(fraud_codes, non_fraud_codes, mmc_codes, merchant_map, min_charges, charges):
    # cast min_charges to integer
    min_charges = int(min_charges)

    # tokenise fraud_codes and non_fraud_codes
    fraud_codes = fraud_codes.split(",")
    non_fraud_codes = non_fraud_codes.split(",")

    # parse mmc_codes and merchant_map to dictionaries
    account_map = {}
    mmc_thresholds = {}

    for code in mmc_codes:
        account_type, threshold = code.split(",")
        mmc_thresholds[account_type] = threshold

    for merchant in merchant_map:
        account_id, account_type = merchant.split(",")
        account_map[account_id] = float(mmc_thresholds[account_type])

    fraud_accounts = []
    ## add logic here

    return fraud_accounts
```

it took me about 10 minutes to figure out what the problem is asking for and the next 5 minutes to write out this data processing part.

then i started writing out the actual logic for the algorithm. if you carefully analyse the constraints in the three parts, you will observe that part 1 is fundamentally different from other parts whereas part 3 is just a buildup extension over part 2. I overlooked this initially and implemented the logic for part 3 directly.

```python
def solve(fraud_codes, non_fraud_codes, mmc_codes, merchant_map, min_charges, charges):
    # cast min_charges to integer
    min_charges = int(min_charges)

    # tokenise fraud_codes and non_fraud_codes
    fraud_codes = fraud_codes.split(",")
    non_fraud_codes = non_fraud_codes.split(",")

    # parse mmc_codes and merchant_map to dictionaries
    account_map = {}
    mmc_thresholds = {}

    for code in mmc_codes:
        account_type, threshold = code.split(",")
        mmc_thresholds[account_type] = threshold

    for merchant in merchant_map:
        account_id, account_type = merchant.split(",")
        account_map[account_id] = float(mmc_thresholds[account_type])

    fraud_accounts = []
    account_info = {}
    charges_map = {}
    for charge in charges:
        charge = charge.split(",")
        if charge[0] == "DISPUTE":
            account_id = charge[1]

            account_info[account_id][0] -= 1
            account_info[account_id][1] += 1

            fraud_count = account_info[account_id][0]
            non_fraud_count = account_info[account_id][1]
            fraud_threshold = account_map[account_id]

            if fraud_count + non_fraud_count >= min_charges and account_id in fraud_accounts:
                if fraud_count / (fraud_count + non_fraud_count) < fraud_threshold:
                    fraud_accounts.remove(account_id)


        elif charge[0] == "CHARGE":
            charge_id, account_id, amount, code = charge[1], charge[2], charge[3], charge[4]
            charges_map[charge_id] = [account_id, amount, code]

            if account_id not in account_info:
                account_info[account_id] = [0, 0]

            if code in fraud_codes:
                account_info[account_id][0] += 1

            else:
                account_info[account_id][1] += 1

            fraud_count = account_info[account_id][0]
            non_fraud_count = account_info[account_id][1]
            fraud_threshold = account_map[account_id]

            if fraud_count + non_fraud_count >= min_charges and account_id not in fraud_accounts:
                if fraud_count / (fraud_count + non_fraud_count) < fraud_threshold:
                    fraud_accounts.remove(account_id)

    
    return ','.join(fraud_accounts)
```

took me about 15 minutes to code this up and after that I had only 17/25 testcases passing. I was figuring out what went wrong and that's when I realised I didn't code the part 1.

the fix is very simple though but it took me a while to get the testcases passing because i messed up my inequalities

```python
def solve(fraud_codes, non_fraud_codes, mmc_codes, merchant_map, min_charges, charges):
    # cast min_charges to integer
    min_charges = int(min_charges)

    # tokenise fraud_codes and non_fraud_codes
    fraud_codes = fraud_codes.split(",")
    non_fraud_codes = non_fraud_codes.split(",")

    # parse mmc_codes and merchant_map to dictionaries
    account_map = {}
    mmc_thresholds = {}

    for code in mmc_codes:
        account_type, threshold = code.split(",")
        mmc_thresholds[account_type] = threshold

    for merchant in merchant_map:
        account_id, account_type = merchant.split(",")
        account_map[account_id] = float(mmc_thresholds[account_type])

    fraud_accounts = []
    account_info = {}
    charges_map = {}
    for charge in charges:
        charge = charge.split(",")
        if charge[0] == "DISPUTE":
            account_id = charge[1]

            account_info[account_id][0] -= 1
            account_info[account_id][1] += 1

            fraud_count = account_info[account_id][0]
            non_fraud_count = account_info[account_id][1]
            fraud_threshold = account_map[account_id]

            if fraud_count + non_fraud_count >= min_charges and account_id in fraud_accounts:
                if fraud_threshold < 1:
                    if fraud_count / (fraud_count + non_fraud_count) < fraud_threshold:
                        fraud_accounts.remove(account_id)

                else:
                    if fraud_count < fraud_threshold:
                        fraud_accounts.remove(account_id)


        elif charge[0] == "CHARGE":
            charge_id, account_id, amount, code = charge[1], charge[2], charge[3], charge[4]
            charges_map[charge_id] = [account_id, amount, code]

            if account_id not in account_info:
                account_info[account_id] = [0, 0]

            if code in fraud_codes:
                account_info[account_id][0] += 1

            else:
                account_info[account_id][1] += 1

            fraud_count = account_info[account_id][0]
            non_fraud_count = account_info[account_id][1]
            fraud_threshold = account_map[account_id]

            if fraud_count + non_fraud_count >= min_charges and account_id not in fraud_accounts:
                if fraud_threshold < 1:
                    if fraud_count / (fraud_count + non_fraud_count) >= fraud_threshold:
                        fraud_accounts.append(account_id)

                else:
                    if fraud_count >= fraud_threshold:
                        fraud_accounts.append(account_id)


    return ','.join(fraud_accounts)
```

with 15 minutes on the clock I had 24/25 testcases passing and I had no clue why the that last testcase failed. but I moved some code here and there and changed inequalities to strict inequalities and it worked luckily and I was able to pass all the 25/25 testcases with 5 minutes remaining on the clock.

I'm waiting for the result honestly. I think this should be an easy qualification, but let's not get the hopes too high. Meanwhile I'm gonna prepare for the bug-bash and integration rounds.

