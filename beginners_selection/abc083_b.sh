#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc083_b
#
# My approach to solve
# 1. Disassemble numbers by digit using / and %
# 2. if it is between a and b, then add the sum of digit number.

read n a b

# [BEGIN] validation

if [ $n -lt 1 ] || [ $n -gt 10000 ]; then
    echo "invalid param n = $n"
    exit 1
fi
if [ $a -lt 1 ] || [ $a -gt $b ]; then
    echo "invalid param a = $a"
    exit 2
fi
if [ $b -lt $a ] || [ $b -gt 36 ]; then
    echo "invalid param b = $b"
    exit 3
fi

# [  END] validation

total_sum=0
for ((i = 1; i <= n; i++))
do
    digit_5=$((i/10000))
    digit_4=$((i/1000%10))
    digit_3=$((i/100%10))
    digit_2=$((i/10%10))
    digit_1=$((i%10))
    sum_of_digits=$((digit_5+digit_4+digit_3+digit_2+digit_1))
    #echo "[DEBUG] i=$i, sum_of_digits=$sum_of_digits"

    if [ $sum_of_digits -ge $a ] && [ $sum_of_digits -le $b ]; then
        total_sum=$((total_sum+i))
        #echo "[DEBUG] current total_sum=$total_sum ($sum_of_digits, $i, $a, $b)"
    fi
done

echo $total_sum
exit 0