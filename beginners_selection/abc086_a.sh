#!/bin/bash

#This code is an answer for the following question.
#https://atcoder.jp/contests/abs/tasks/abc086_a

function validate_number(){
    if [ $1 -ge 1 ] && [ $1 -le 10000 ] ; then
        return 0
    else
        return 1
    fi
}

# @return 0 when even, 1 when odd
function judge_even(){
    even=$(($1%2))
    return $even
}

read a b
validate_number $a
if [ $? -ne 0 ]; then
    echo "invalid param a=$a"
    exit 1
fi
validate_number $b
if [ $? -ne 0 ]; then
    echo "invalid param b=$b"
    exit 2
fi

# OK pattern
judge_even $(($a*$b))
if [[ $? -eq 0 ]]; then
    answer="Even"
else
    answer="Odd"
fi
echo "$answer"
exit 0