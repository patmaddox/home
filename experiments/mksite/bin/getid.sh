#!/bin/sh
basename $1 | sed 's/^\([[:digit:]]*\)-.*/\1/'
