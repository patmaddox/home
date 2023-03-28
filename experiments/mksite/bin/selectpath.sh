#!/bin/sh
path=$(sqlite3 paths/paths.sql "select path from paths where id=$1")
if [ -z $path ]; then
   echo "Error: No path for $1"
   exit 1
fi
echo $path
