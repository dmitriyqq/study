#!/bin/bash
FILES=./queries/*
for f in $FILES
do
  echo "Processing $f file..."
  b=$(basename $f)
  base="${b/sql/tex}"
  ./script_executor/execute_query.js $f "./subfiles/$base"
  cat $f
done
