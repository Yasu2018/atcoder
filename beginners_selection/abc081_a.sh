#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc081_a
#
# My approach to solve
# 1. Too simple to explain logic

count=0
for i in {1..3}
do
  read -s -n 1 hoge
  if [ $hoge -eq 1 ]; then
    count=$((count+=1))
  fi
done
echo $count
exit 0