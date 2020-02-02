#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc086_c
#
# My approach to solve
# 1. calc "distance" by abs(x[i+1]-x[i]) + abs(y[i+1]-y[i])
# 2. check a person can reach there by the next designated turn ("distance" <= t[i+1] - t[i])
# 3. even over the distance, we can control as long as the remaining is multiple by 2.
# (e.g.) I have to reach the point (distance=1) in 5 turn. => Just go back and force twice, and move to the target point.

read N

# [BEGIN] validation for N
if [ $N -lt 1 ] || [ $N -gt 100000 ]; then
    echo "invalid param N = $N"
    exit 1
fi
# [  END] validation for N

previous_x=0
previous_y=0
previous_t=0
for ((i = 0; i < N; i++)); do
    read t x y

    # [BEGIN] validation for t, x, and y
    if [ $t -lt 1 ] || [ $t -gt 100000 ]; then
        echo "invalid param t = $t"
        exit 2
    fi
    if [ $x -lt 0 ] || [ $x -gt 100000 ]; then
        echo "invalid param x = $x"
        exit 3
    fi
    if [ $y -lt 0 ] || [ $y -gt 100000 ]; then
        echo "invalid param y = $y"
        exit 4
    fi
    if [ $t -le $previous_t ]; then
        echo "t ($t) must be bigger than the previous t ($previous_t)"
        exit 5
    fi
    # [  END] validation for t, x, and y

    diff_x=$((x-previous_x))
    if [ $diff_x -lt 0 ]; then
        diff_x=$((diff_x*-1))
    fi
    diff_y=$((y-previous_y))
    if [ $diff_y -lt 0 ]; then
        diff_y=$((diff_y*-1))
    fi

    distance=$((diff_x+diff_y))
    move_capacity=$((t-previous_t))
    #echo "[DEBUG] distance($distance), move_capacity($move_capacity)"
    if [ $move_capacity -lt $distance ] || [ $(((move_capacity-distance)%2)) -ne 0 ]; then
        echo "No"
        exit 6
    fi
    previous_x=$x
    previous_y=$y
    previous_t=$t
done

echo "Yes"
exit 0