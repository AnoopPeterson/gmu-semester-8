#!/usr/bin/python
import sys
import string
for line in sys.stdin:
    line = line.strip()
    words = line.split()
    sys.stdout.write('{}\t{}\t{}\n'.format(words[0], words[1], words[2]))
