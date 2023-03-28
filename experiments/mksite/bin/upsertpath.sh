#!/bin/sh
getid=$(dirname $0)/getid.sh
getpath=$(dirname $0)/getoutpath.sh

id=$($getid $1)
path=$($getpath $1)

sqlite3 -cmd '.timeout 100' paths/paths.sql "insert into paths values($id, '$path') on conflict(id) do update set path='$path'"
