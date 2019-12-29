#!/bin/bash

#This code is an answer for the following question.
#https://atcoder.jp/contests/abs/tasks/abc081_a

#@return 0 is the input value is 0
function read_and_check_zero()
{
    read -s -n 1 hoge
    if [ $hoge -eq 0 ]; then
        return 0
    fi
    #does not consider when neither 0 nor 1 
    return 1
}

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