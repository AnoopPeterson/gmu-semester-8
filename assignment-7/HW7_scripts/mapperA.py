#!/usr/bin/python
import sys
import string
for line in sys.stdin:
    line = line.strip()
    words = line.split(',')
    sys.stdout.write('{}\t{}\t{}\n'.format(words[3], words[-3], 1))
