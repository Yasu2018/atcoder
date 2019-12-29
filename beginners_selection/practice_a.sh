#!/bin/bash

#This code is an answer for the following question.
#https://atcoder.jp/contests/abs/tasks/practice_1

function validate_number(){
    if [ $1 -ge 1 ] && [ $1 -le 1000 ] ; then
        return 0
    else
        return 1
    fi
}

read a
validate_number $a
if [ $? -ne 0 ]; then
    echo "invalid param a=$a"
    exit 1
fi

read b c
validate_number $b
if [ $? -ne 0 ]; then
    echo "invalid param b=$b"
    exit 2
fi
validate_number $c
if [ $? -ne 0 ]; then
    echo "invalid param c=$c"
    exit 3
fi

read s

readonly s_length=${#s} 
if [ $s_length -lt 1 ] || [ $s_length -gt 1000 ]; then
    echo "invalid param (length of s)=$s_length"
    exit 4
fi

# OK pattern
echo "$((a+b+c)) $s"
exit 0