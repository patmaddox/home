#!/bin/sh

file=$1

if [ ! -f $file ]; then
    echo "usage: getoutpath.sh <file>"
    exit 1
fi

fmpath=$(sed -n '/---/,/---/p' $file | grep '^path:' | sed -e 's/^path: //')

if [ -z $fmpath ]; then
    outpath=$(echo $file | sed -e 's|^src/|out/|' -e 's/.md$//')
else
    outpath=out/${fmpath}
fi

echo ${outpath}.html
