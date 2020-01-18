#!/bin/bash

#This code is an answer for the following question.
#https://atcoder.jp/contests/abs/tasks/abc081_b

read n
read -a array

# [BEGIN] validation

if [ $n -lt 1 ] || [ $n -gt 200 ]; then
    echo "invalid param n = $n"
    exit 1
fi

for a in ${array[@]}; do
    if [ $a -lt 1 ] || [ $a -gt 10000000000 ]; then
        echo "invalid param a = $a"
        exit 2
    fi
done

# [  END] validation

count=0
for ((count = 0; ; count++))
do
    for ((i = 0; i < ${#array[@]}; i++))
    do
        if [ $((array[$i]%2)) -ne 0 ]; then
            echo "$count"
            exit 0
        else
            array[$i]=$((array[$i]/2))
        fi
    done
done