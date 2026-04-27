#!/bin/bash
hadoop jar /usr/lib/hadoop/hadoop-streaming.jar \
-files ebook_map.py,ebook_reduce.py \
-mapper "python3 ebook_map.py" \
-reducer "python3 ebook_reduce.py" \
-input books-input \
-output books-output
