#!/bin/sh

file=$1

if [ ! -f $file ]; then
    echo "usage: getoutpath.sh <file>"
    exit 1
fi

fmpath=$(sed -n '/---/,/---/p' $file | grep '^path:' | sed -e 's/^path: //')

dir=$(echo $file | sed -e 's|^src/|out/|' | xargs dirname)
base=$(basename $file)

if [ -z $fmpath ]; then
    file=$(echo $base | sed -e 's/^[[:digit:]]*-//' -e 's/.md$//')
    outpath=${dir}/${file}
else
    outpath=out/${fmpath}
fi

echo ${outpath}.html
