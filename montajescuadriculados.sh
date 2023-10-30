#!/bin/bash
dimension=$1
format=$2
namez=$3
shift
shift
shift
amount=$#
allowed=(01 04 09 16 25 36 49 64 81)
for i in "${!allowed[@]}"; do
   if [[ "${allowed[$i]}" = "${amount}" ]]; then
   		sum=1
    	index=$((i + sum))
   fi
done
file=$1
file=${file##*/}
datex="${file%%_*}"
count=0
files=$@
for word in ${files[*]}; do
    if [[ $word =~ $datex ]]; then
        (( count++ ))
    fi
done 
if [ $amount -eq $count ]; then
	rename="${datex}__${namez}${amount}.${format}"
else
	rename="${datex%-*}-00__${namez}${amount}.${format}"
fi
if [[ " ${allowed[*]} " =~ " ${amount} " ]]; then
	size="-tile ${index}x${index}"
else
	size=""
fi
montage "$@" $size -geometry ${dimension}x${dimension}+0+0 -background black $rename
