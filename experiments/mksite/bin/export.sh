#!/bin/sh
set -e
set -o pipefail
cat ${1} | sed -e '/^---$/,/^---$/d' | markdown -o ${2}
