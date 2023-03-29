#!/bin/sh

mksite_export()
{
    mypath=$(mksite_getoutpath ${1})
    mydir=$(dirname $mypath)
    if [ ! -d $mydir ]; then mkdir -p $mydir; fi

    ids=$(cat $1 | grep -o '(%[[:digit:]]*%)' | grep -o '[[:digit:]]*' | sort -u)
    replace="-e '/^---$/,/^---$/d'"

    for id in $ids; do
	file=$(find src -name "${id}-*.md")
	path=$(mksite_getoutpath $file)
	therelpath=$(mksite_relpath $mypath $path)
	replace="${replace} -e 's;(%${id}%);(${therelpath});g'"
    done

    eval "sed $replace" $1 | markdown -o $2
}

mksite_getid()
{
    id=$(basename $1 | sed -n 's/^\([[:digit:]]*\)-.*/\1/p')
    if [ -n "$id" ]; then
	echo $id
    fi
}

mksite_getlinks()
{
    file=$1
    id=$(mksite_getid $file)
    links=$(grep -rl "(%${id}%)" src | sort -u) # | grep -o '[[:digit:]]*')

    for link in $links; do
	echo $(mksite_getoutpath $link)
    done
}

mksite_getoutpath()
{
    file=$1
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
}

mksite_relpath()
{
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
}

cmd=$1
shift
mksite_${cmd} "$@"
