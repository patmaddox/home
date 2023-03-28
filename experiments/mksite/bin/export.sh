#!/bin/sh
set -e
set -o pipefail

getpath=$(dirname $0)/getoutpath.sh
selectpath=$(dirname $0)/selectpath.sh
relpath=$(dirname $0)/relpath.sh

mypath=$($getpath ${1})
mydir=$(dirname $mypath)
if [ ! -d $mydir ]; then mkdir -p $mydir; fi

ids=$(cat $1 | grep -o '(%[[:digit:]]*%)' | grep -o '[[:digit:]]*' | sort -u)
replace="-e '/^---$/,/^---$/d'"

for id in $ids; do
    path=$($selectpath $id)
    therelpath=$($relpath $mypath $path)
    replace="${replace} -e 's;(%${id}%);(${therelpath});g'"
done

eval "sed $replace" $1 | markdown -o $2
