#!/bin/sh
getid=$(dirname $0)/getid.sh

file=$1
links=$(grep -o "(%$($getid $file)%)" -rl src)
echo "$links"
