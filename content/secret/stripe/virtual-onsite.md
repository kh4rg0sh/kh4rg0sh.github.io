---
title: Stripe Virtual Onsite (New Grad)
type: docs
weight: 4
math: true
---

I took the Stripe Virtual Onsite Round on 27th October, 2025. I'm under an NDA that says that I'm not allowed to disclose the problems so I'm just going to detail my experience apart from the problems asked to me in the interview.

This round was a two part interview, both 1 hour long with a 15 minute break in between. The first interview was a programming exercise, where I had to solve an implementation exercise that had 4 parts in 35 minutes. I managed to clutch all the 4 parts right in time with code for all the parts. The second interview was bug squash round (aka debugging round). 

You will be given a github repository of a medium sized codebase and some github issues in that repository. You are supposed to git clone the repository and run the tests and fix all the tests one by one by navigating through the codebase. The repository that I had been provided had 3 issues and I was able to fix 2 of these in 1 hour. I cannot disclose the bugs but they were all one line fixes. They really just want to see your debugging speed, thought process and hypothesis formation and rejection skills for bugs in an unfamiliar codebase. This is not that difficult if you really know the ins and outs of the language you are working with. You should be familiar with reading errors in the language of your choice and also should know how to use a standard recommended debugger for the language of your choice. For example I did this in python. Python does a very good job with locating the line causing error as well as the description for cause of error. The stacktrace in python errors help you easily navigate through the flow of nested function calls helping you to easily locate the line that caused the error. Apart from this static analysis, you might also want to be able to have tools that help you dynamically analyse the state of the program so that you can inspect and locate the error as well as argue what must have happened that caused the error. The python standard library comes with "pdb" (python debugger) that helps you do a lot more than just dynamically pause and inspect the program state. I used pdb to solve the second bug for which I had to dive a lot deeper inside the codebase navigating through a lot of methods and reason for what might be causing the bug. 

This was honestly a fun experience and I did quite well in both the parts and I was happy with my performance so I'm expecting the invitation to the next round!

## Update [17th November, 2025]
I got the offer! Here is the summary of what I was told in my offer:

1. Compensation
there are three components in the Compensation:
- Base Salary: 28,06,000 per year fixed + 10% of the fixed as performance bonus
which makes the total => 30,86,600 per year
- Bonuses:
joining bonus: 7,60,000 one time
relocation: 8,50,000 one time
- ESOPs:
annual employee bonus: 26800 USD per year
performance bonus: no limit
which is around 68 to 70 LPA

2. Benefits
- free transportation
- free breakfast and lunch
- medical and health insurance
- 8000 USD worth sports allowance every month


