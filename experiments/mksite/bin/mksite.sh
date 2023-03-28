#!/bin/sh

mksite_export()
{
    mypath=$(mksite_getoutpath ${1})
    mydir=$(dirname $mypath)
    if [ ! -d $mydir ]; then mkdir -p $mydir; fi

    ids=$(cat $1 | grep -o '(%[[:digit:]]*%)' | grep -o '[[:digit:]]*' | sort -u)
    replace="-e '/^---$/,/^---$/d'"

    for id in $ids; do
	path=$(mksite_selectpath $id)
	therelpath=$(mksite_relpath $mypath $path)
	replace="${replace} -e 's;(%${id}%);(${therelpath});g'"
    done

    eval "sed $replace" $1 | markdown -o $2
}

mksite_getid()
{
    id=$(basename $1 | sed 's/^\([[:digit:]]*\)-.*/\1/')
    echo $id
}

mksite_getlinks()
{
    file=$1
    links=$(grep -o '(%[[:digit:]]*%)' $file | sort -u | grep -o '[[:digit:]]*' | xargs -I {} -n 1 find src -type f -name '{}-*')
    echo "$links"
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

mksite_selectpath()
{
    path=$(sqlite3 paths/paths.sql "select path from paths where id=$1")
    if [ -z $path ]; then
	echo "Error: No path for $1"
	exit 1
    fi
    echo $path
}

mksite_upsertpath()
{
    id=$(mksite_getid $1)
    path=$(mksite_getoutpath $1)

    sqlite3 -cmd '.timeout 100' paths/paths.sql "insert into paths values($id, '$path') on conflict(id) do update set path='$path'"
}

cmd=$1
shift
mksite_${cmd} "$@"
