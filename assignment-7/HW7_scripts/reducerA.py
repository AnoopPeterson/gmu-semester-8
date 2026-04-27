#!/usr/bin/python
from collections import defaultdict
import sys

word_count = defaultdict(int)
word_tally = defaultdict(int)
words = set()
for line in sys.stdin:
    try:
        line = line.strip()
        word, count, tally = line.split()
        words.add(word)
        # print(word, count, tally)
        
        count = int(float(count))
        
        word_tally[word] = word_tally[word] + int(tally)
        word_count[word] = word_count[word] + count
    except:
        continue

reduced = {word: (word_count[word], word_tally[word]) for word in words}
for word, (count, total) in reduced.items():
    sys.stdout.write('{}\t{}\t{}\n'.format(word, count, total))
