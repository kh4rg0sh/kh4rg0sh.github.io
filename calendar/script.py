import os
tarf = os.path.join(os.getcwd(), "entries")

def encrypt(content):
    encrypted = content
    return encrypted

for file in os.listdir(tarf):
    if file.startswith("copy-"):
        continue

    path = os.path.join(tarf, file)
    with open(path, "r", encoding="utf-8") as f:
        content = f.read().split('\n', 1)
        if len(content) < 2:
            continue
        encrypted = encrypt(content[1])
    
    new_file = "copy-" + file
    new_path = os.path.join(tarf, new_file)
    with open(new_path, 'w') as f:
        f.write(content[0])
        f.write('\n')
        f.write(content[1])

    with open(path, 'w') as f:
        f.write(content[0])
        f.write('\n')
        f.write(encrypted)

            