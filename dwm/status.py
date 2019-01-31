#!/usr/bin/python3
import fileinput
import json
import re
import subprocess

for _ in range(5):
    input()

for line in fileinput.input():
    data = json.loads(line[1:])
    out = []
    for d in data:
        if d['full_text'] == '':
            continue
        out.append(re.sub('<.*?>', '', d['full_text']))
    subprocess.run(['xsetroot', '-name', '  |  '.join(out)])

