#!/bin/sh
set -e
set -o pipefail

mypath=$(cat paths/${1})

ids=$(cat $1 | grep -o '(%[[:digit:]]*%)' | grep -o '[[:digit:]]*' | sort -u)
replace="-e '/^---$/,/^---$/d'"
for id in $ids; do
    file=$(find src -type f -name ${id}-*)
    path=$(cat paths/${file} | sed -e 's|^out/||')
    replace="${replace} -e 's;(%${id}%);(${path});g'"
done

eval "sed $replace" $1 | markdown -o $2
