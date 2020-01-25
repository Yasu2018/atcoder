#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc085_b
#
# My approach to solve
# 1. sort all numbers without n order by desc
# 2. count up if index(n-1) is greater than index(n) in a loop

read n
if [ $n -lt 1 ] || [ $n -gt 100 ]; then
    echo "invalid param n = $n"
    exit 1
fi

array=()
for ((i = 0; i < n; i++)); do
    read array[i]
    if [ ${array[i]} -lt 1 ] || [ ${array[i]} -gt 100 ]; then
        echo "invalid param d$i = ${array[i]}"
        exit 2
    fi
done

#echo "[DEBUG] ${array[@]}"

sorted_array=($(printf "%s\n" "${array[@]}" | sort -n -r | tr "\n" " "))

count=1
for ((i = 1; i < n; i++)); do
    #echo "[DEBUG] ${sorted_array[i-1]} > ${sorted_array[i]}"
    if [ ${sorted_array[i-1]} -gt ${sorted_array[i]} ]; then
        count=$((count+1))
    fi
done

echo $count

exit 0