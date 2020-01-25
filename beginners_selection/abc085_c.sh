#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc085_c
#
# My approach to solve
# 1. x is number of 10000 paper, y is number of 5000 paper, z is number of 1000 paper.
# 2. assume that the x is possible maximum number, and start a loop
# 3. if too much when y = 0, or too less when z = 0, continue the loop
# 4. if the Y - (x * 10000) % 4000 is not 0, no meaning adjustment for y and z, continue the loop
# 5. x and y are over the N, no need calculation, continue the loop
# 6. otherwise, you got the answer.

read N Y

# [BEGIN] validation

if [ $N -lt 1 ] || [ $N -gt 2000 ]; then
    echo "invalid param N = $N"
    exit 1
fi
if [ $Y -lt 1000 ] || [ $Y -gt 20000000 ]; then
    echo "invalid param Y = $Y"
    exit 2
fi
if [ $((Y%1000)) -ne 0 ]; then
    echo "$Y must be able to be devided by 1000"
    exit 3
fi


# [  END] validation

# if cannot reach the Y even using all 10000 paper, then no need calculation.
if [ $((N*10000)) -lt $Y ]; then
    echo "-1 -1 -1"
    exit 4
fi

# possible maximum x
max_x=$((Y/10000))

order=0
for ((x = max_x; 0 <= x; x--)); do
    order=$((order+1))

    max_adjustable_amount=$((x*10000+5000*(N-x)))
    if [ $max_adjustable_amount -lt $Y ]; then
        #too less even maximum y, no need calculation anymore.
        echo "-1 -1 -1"
        exit 4
    fi

    min_adjustable_amount=$((x*10000+1000*(N-x)))
    if [ $min_adjustable_amount -gt $Y ]; then
        #too much even minumum y, no need considering this pattern.
        #decrement x
        continue
    fi

    # assert possible in case of this x

    diff_amount=$((Y-min_adjustable_amount))
    # 4000 is decreasing y and increasing z
    if [ $((diff_amount%4000)) -ne 0 ]; then
        # no meaning adjustment. decrease x
        continue
    fi

    y=$diff_amount/4000
    if [ $((x+y)) -gt $N ]; then
        # no meaning adjustment. decrease x
        continue
    fi

    y=$((diff_amount/4000))
    echo "$x $y $((N-x-y)) order=$order"
    exit 0
done

echo "-1 -1 -1"
exit 4