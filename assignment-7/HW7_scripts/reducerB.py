#!/usr/bin/env python3
from collections import defaultdict
import sys

word_averages = defaultdict(int)
for line in sys.stdin:
    try:
        line = line.strip()
        word, count, total = line.split()
        count = int(count)
        total = int(total)

    except:
        continue
    word_averages[word] = count/total

for word, average in word_averages.items():
    sys.stdout.write('{}\t{}\n'.format(word, average))
