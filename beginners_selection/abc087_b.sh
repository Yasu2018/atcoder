#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abs/tasks/abc087_b
#
# My approach to solve
# 1. Try using max number of a, b, c to reach x.
# 2. Then try to reduce numer from c one by one.
# 3. It mean using triple loop to reduce the number of a, b, c

read count_of_500_yen_coin #same as "a"
read count_of_100_yen_coin #same as "b"
read count_of_50_yen_coin #same as "c"
read total_amount #same as "x"

# [BEGIN] validation

if [ $count_of_500_yen_coin -lt 0 ] || [ $count_of_500_yen_coin -gt 50 ]; then
    echo "invalid param count_of_500_yen_coin = $count_of_500_yen_coin"
    exit 1
fi
if [ $count_of_100_yen_coin -lt 0 ] || [ $count_of_100_yen_coin -gt 50 ]; then
    echo "invalid param count_of_100_yen_coin = $count_of_100_yen_coin"
    exit 2
fi
if [ $count_of_50_yen_coin -lt 0 ] || [ $count_of_50_yen_coin -gt 50 ]; then
    echo "invalid param count_of_50_yen_coin = $count_of_50_yen_coin"
    exit 3
fi
if [ $((count_of_500_yen_coin + count_of_100_yen_coin + count_of_50_yen_coin)) -lt 1 ]; then
    echo "count_of_500_yen_coin + count_of_100_yen_coin + count_of_50_yen_coin must be 1 or more"
    exit 4
fi
if [ $total_amount -lt 50 ] || [ $total_amount -gt 20000 ]; then
    echo "invalid param total_amount = $total_amount"
    exit 5
fi
if [ $((total_amount % 50)) -ne 0 ]; then
    echo "total_amount ($total_amount) must be able to be devided by 50!"
    exit 6
fi

# [  END] validation


# calc a pattern changing the number of 500 yen coins by decreasing.
used_count_of_500_yen_coin=$count_of_500_yen_coin

# if there are 10 of 500 coins, and total_amount is 2xxx,
# we don't need to calc the number of 500 coins when from 10 to 6.
# hence, starting to calc from 5 to 0.
if [ $used_count_of_500_yen_coin -gt $((total_amount/500)) ]; then
    used_count_of_500_yen_coin=$((total_amount/500))
fi

#echo "[DEBUG] used_count_of_500_yen_coin=$used_count_of_500_yen_coin"

number_of_calc_way=0
for ((; 0 <= used_count_of_500_yen_coin; used_count_of_500_yen_coin--))
do
    shortage_amount=$((total_amount-used_count_of_500_yen_coin*500))
    if [ $shortage_amount -eq 0 ]; then
        #echo "[DEBUG] !!!! can calc when using only 500 yen coins"
        number_of_calc_way=$((number_of_calc_way+1))
    else
        # assert 0 < $remaining_amount
        # calc a pattern changing the number of 100 yen coins.
        used_count_of_100_yen_coin=$count_of_100_yen_coin

        # if there are 10 coins of 100 yen, and remaining_amount is 2xx,
        # we don't need to calc the number of coins for 100 yen when from 10 to 3.
        # hence, starting to calc from 2 to 0.
        if [ $used_count_of_100_yen_coin -gt $((shortage_amount/100)) ]; then
            used_count_of_100_yen_coin=$((shortage_amount/100))
        fi
        #echo "[DEBUG] used_count_of_100_yen_coin=$used_count_of_100_yen_coin"
        for ((; 0 <= used_count_of_100_yen_coin; used_count_of_100_yen_coin--))
        do
            tmp=$((shortage_amount-used_count_of_100_yen_coin*100))
            #assert tmp % 50 == 0
            if [ $tmp -le $((count_of_50_yen_coin*50)) ]; then
                # e.g. tmp = 150 and there are 5 coins of 50 yen
                #echo "[DEBUG] !!!! can calc when $used_count_of_500_yen_coin, $used_count_of_100_yen_coin, and $((tmp/50))"
                number_of_calc_way=$((number_of_calc_way+1))
            fi
        done
    fi
done

echo "$number_of_calc_way"
exit 0