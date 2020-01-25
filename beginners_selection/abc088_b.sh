#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc088_b
#
# My approach to solve
# 1. sort the input numbers order by desc using "sort" command
# 2. the result of the sort command has line, hence convert to array with "tr" command
# 3. just calc total sum of (index0-index1), and (index2 - index3), ...

read n
read -a array

# [BEGIN] validation

if [ $n -lt 1 ] || [ $n -gt 100 ]; then
    echo "invalid param n = $n"
    exit 1
fi
for a in ${array[@]}; do
    if [ $a -lt 1 ] || [ $a -gt 100 ]; then
        echo "invalid param a = $a"
        exit 2
    fi
done
if [ ${#array[@]} -ne $n ]; then
    echo "the length array of a is invalid. ${#array[@]}"
    exit 3
fi

# [  END] validation
# assert $n equals ${array[@]}

sorted_array=($(printf "%s\n" "${array[@]}" | sort -n -r | tr "\n" " "))
#echo "[DEBUG] sorted_array=${sorted_array[@]}, length=${#sorted_array[@]}"

# would like to get
#length_of_array => loop_end_index
#2 -> 1 (use index from 0 to 1)
#3 -> 1
#4 -> 3 (use index from 0 to 3)
#5 -> 3
#6 -> 5
#7 -> 5
#8 -> 7
loop_end_index=$((n-1-n%2))
#assert loop_end_index must be "odd", not "even"
#echo "[DEBUG] loop_end_index=$loop_end_index"


tmp=0
for ((i = 0; i < loop_end_index; i+=2)); do
    diff=$((${sorted_array[i]}-${sorted_array[i+1]}))
    tmp=$((tmp+diff))
done

if [ $((n%2)) -eq 1 ]; then
    last_value=${sorted_array[n-1]}
    tmp=$((tmp+last_value))
fi

echo $tmp

exit 0