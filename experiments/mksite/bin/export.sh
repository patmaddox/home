#!/bin/sh
set -e
set -o pipefail

getpath=$(dirname $0)/getoutpath.sh
selectpath=$(dirname $0)/selectpath.sh

mypath=$($getpath ${1})

ids=$(cat $1 | grep -o '(%[[:digit:]]*%)' | grep -o '[[:digit:]]*' | sort -u)
replace="-e '/^---$/,/^---$/d'"
for id in $ids; do
    path=$($selectpath $id | sed -e 's|^out/||')
    replace="${replace} -e 's;(%${id}%);(${path});g'"
done

eval "sed $replace" $1 | markdown -o $2
