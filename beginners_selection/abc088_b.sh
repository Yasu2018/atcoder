#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc088_b
#
# My approach to solve
# 1. sort the input numbers order by desc using "sort" command
# 2. the result of the sort command has line, hence convert to array with "tr" command
# 3. calc total sum of (index0-index1), and (index2 - index3), ...

read card_number #same as N
read -a card_points_array #same as "a1 a2 a3 ..."

# [BEGIN] validation

if [ $card_number -lt 1 ] || [ $card_number -gt 100 ]; then
    echo "[ERROR] invalid param card_number = $card_number"
    exit 1
fi
for point in ${card_points_array[@]}; do
    if [ $point -lt 1 ] || [ $point -gt 100 ]; then
        echo "[ERROR] invalid param point = $point"
        exit 2
    fi
done
if [ ${#card_points_array[@]} -ne $card_number ]; then
    echo "[ERROR] the length card_points_array is invalid. ${#card_points_array[@]}"
    exit 3
fi

# [  END] validation
# assert $card_number equals ${card_points_array[@]}

sorted_points_array=($(printf "%s\n" "${card_points_array[@]}" | sort -n -r | tr "\n" " "))
#echo "[DEBUG] sorted_points_array=${sorted_points_array[@]}, length=${#sorted_points_array[@]}"

score=0
for ((i = 0; i < ${#sorted_points_array[@]}; i++)); do
    if [ $((i % 2)) -eq 0 ]; then
        # if even -> add (Alice's score)
        score=$((score+${sorted_points_array[i]}))
    else
        # if odd -> subtract (Bob's score)
        score=$((score-${sorted_points_array[i]}))
    fi
done

echo $score
exit 0