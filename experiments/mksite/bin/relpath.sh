#!/bin/sh

source_file=$(basename $1)
target_file=$(basename $2)

source_dir=$(dirname $1)
target_dir=$(dirname $2)

common_part=$source_dir
result=

while [ "${target_dir##$common_part}" = $target_dir ]; do
    common_part=$(dirname $common_part)
    result=../$result
done

forward_part=$(echo ${target_dir##$common_part} | sed 's|^/||')

if [ -n "$result" ] && [ -n "$forward_part" ]; then
    result=$result$forward_part/
elif [ -n "$forward_part" ]; then
    result=$forward_part/
fi

echo $result$target_file
