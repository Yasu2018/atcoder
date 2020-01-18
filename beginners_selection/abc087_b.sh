#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc087_b
#
# My approach to solve
# 1. Try using max number of a, b, c to reach x.
# 2. Then try to reduce numer from c one by one.
# 3. It mean using triple loop to reduce the number of a, b, c

read a
read b
read c
read x

# [BEGIN] validation

if [ $a -lt 0 ] || [ $a -gt 50 ]; then
    echo "invalid param a = $a"
    exit 1
fi
if [ $b -lt 0 ] || [ $b -gt 50 ]; then
    echo "invalid param b = $b"
    exit 2
fi
if [ $c -lt 0 ] || [ $c -gt 50 ]; then
    echo "invalid param c = $c"
    exit 3
fi
if [ $((a+b+c)) -lt 1 ]; then
    echo "a + b + c must be 1 or more"
    exit 4
fi
if [ $x -lt 50 ] || [ $x -gt 20000 ]; then
    echo "invalid param x = $x"
    exit 5
fi
if [ $((x%50)) -ne 0 ]; then
    echo "x must be able to be devided by 50! : $x"
    exit 6
fi

# [  END] validation

number_of_calc_way=0
# calc a pattern changing the number of 500 yen coins.
# ac is count of a (how many coins for a)
for ((ac = a; 0 <= ac; ac--))
do
    buf=$((x-ac*500))
    #echo "1buf=$buf"
    if [ $buf -lt 0 ]; then
        #echo "cannot calc when using $ac 500yen coins"
        continue;
    elif [ $buf -eq 0 ]; then
        #echo "!!!! can calc when using $ac 500yen coins"
        number_of_calc_way=$((number_of_calc_way+1))
    else
        # calc a pattern changing the number of 100 yen coins.
        for ((bc = b; 0 <= bc; bc--))
        do
            buf=$((x-ac*500-bc*100))
            #echo "2buf=$buf"
            if [ $buf -lt 0 ]; then
                #echo "cannot calc when using $ac 500yen and $bc 100yen coins"
                continue;
            elif [ $buf -eq 0 ]; then
                #echo "!!!! can calc when using $ac 500yen and $bc 100 yen coins"
                number_of_calc_way=$((number_of_calc_way+1))
            else
                # calc a pattern changing the number of 50 yen coins.
                for ((cc = c; 0 < cc; cc--))
                do
                    buf=$((x-ac*500-bc*100-cc*50))
                    if [ $buf -ne 0 ]; then
                        #echo "cannot calc when using $ac 500yen, $bc 100yen, and $cc 50 yen coins"
                        continue;
                    else
                        #echo "!!!! can calc when using $ac 500yen, $bc 100yen, and $cc 50 yen coins"
                        number_of_calc_way=$((number_of_calc_way+1))
                    fi
                done
            fi
        done
    fi
done

echo "$number_of_calc_way"