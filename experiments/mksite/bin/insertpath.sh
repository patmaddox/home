#!/bin/sh
getid=$(dirname $0)/getid.sh
getpath=$(dirname $0)/getoutpath.sh

sqlite3 -cmd '.timeout 100' paths/paths.sql "insert into paths values($($getid $1), '$($getpath $1)')"
