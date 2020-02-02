#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abc001/tasks/abc001_2

read meter

# [BEGIN] validation
if [ $meter -lt 0 ] || [ $meter -gt 100000 ]; then
    echo "invalid param meter = $meter"
    exit 1
fi
# [  END] validation

# Reference - https://genzouw.com/entry/2019/02/18/122158
km=$(awk "BEGIN { print $meter/1000 }")
#echo "[DEBUG] km=$km"

if [ $meter -lt 100 ]; then
    echo "00"
elif [ $meter -ge 100 ] && [ $meter -le 5000 ]; then
    #Reference - https://qiita.com/daifuku_mochi2/items/e8f17a1a226a418eba56
    echo "$(printf %02d $((meter/100)))"
elif [ $meter -ge 6000 ] && [ $meter -le 30000 ]; then
    echo $((km+50))
elif [ $meter -ge 35000 ] && [ $meter -le 70000 ]; then
    echo $(((km-30)/5+80))
elif [ $meter -ge 70000 ]; then
    echo "89"
fi

exit 0