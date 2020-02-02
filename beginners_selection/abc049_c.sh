#!/bin/bash

# This code is an answer for the following question. (The URL and the question ID are different...)
# https://atcoder.jp/contests/abs/tasks/arc065_a
#
# My approach to solve
# 1. use the regular expression

read target # same as S

if [[ ${target} =~ ^(dream|dreamer|erase|eraser)+$ ]]; then
    echo "YES"
else
    echo "NO"
fi