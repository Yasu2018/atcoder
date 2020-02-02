#!/bin/bash

# This code is an answer for the following question.
# https://atcoder.jp/contests/abc001/tasks/abc001_3
# My approach to solve
# 1. At first, calc W, because if W=0, no need to calc Dir anymore.
# 2. make a threshold array for Dir
# 3. if the rounded Dis / 60 is lower than array[i], then the Dir is i-1.
# e.g. if the rounded Dis / 60 is 3.1, it is lower than 3.3 (array[3]), hence Dir is 2
# 4. if Dir is not zero, let's calc W
# 5. The beginning direction does not start from zero, hence adjust for easy calculation.
# e.g. The beinning 'N' is from 348.75 (-11.25) to 11.25,
# hence plus 11.25, then N will be from zero to 22.5.
# 6. prepare master values array for all directions ["N", "NNE" ... ] (size=16)
# 7. divide Deg by 22.5 (22.5 is 360 / 16), then all values belong to from zero to 16.
# 8. pick up the index and get the master value from it.

read Deg Dis

# [BEGIN] validation
if [ $Deg -lt 0 ] || [ $Deg -ge 3600 ]; then
    echo "invalid param Deg = $Deg"
    exit 1
fi
if [ $Dis -lt 0 ] || [ $Dis -ge 12000 ]; then
    echo "invalid param Dis = $Dis"
    exit 2
fi
# [  END] validation

readonly wind_threshold_array=(0 3 16 34 55 80 108 139 172 208 245 285 327)
#echo "[DEBUG] $((Dis*10/60))"

#round (四捨五入)
wind_m10s=$(((Dis*100/60+5)/10))
#wind_m10s has 10 times value of m/s

W=12
for ((i = 1; i <= 12; i++)); do
    #echo "[DEBUG] $wind_m10s ${wind_threshold_array[i]}"
    if [ $wind_m10s -lt ${wind_threshold_array[i]} ]; then
        W=$((i-1))
        break
    fi
done
if [ $W -eq 0 ]; then
    echo "C 0"
    exit 0
fi
#echo "[DEBUG] W=$W"

readonly dir_array=("N" "NNE" "NE" "ENE" "E" "ESE" "SE" "SSE" "S" "SSW" "SW" "WSW" "W" "WNW" "NW" "NNW")
#Dir_index=$(awk "BEGIN { print ($Deg-112.5)/16 }")
if [ $Deg -lt 112 ]; then
    Dir = "N"
else
    Dir_index=$(((Deg+112)/225))
    Dir=${dir_array[Dir_index]}
    #echo "[DEBUG] Dir=$Dir, Dir_index=$Dir_index"
fi

echo "$Dir $W"
exit 0