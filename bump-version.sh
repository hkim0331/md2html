#!/bin/sh
# -*- mode: Shell-script; coding: utf-8; -*-
# update 2017-03-19.

if [ $# -ne 1 ]; then
    echo usage: $0 VERSION
    exit
else
    VERSION=$1
fi

TODAY=`date +%F`

# linux's sed is gnu sed, macos not.
if [ -e /usr/local/bin/gsed ]; then
    SED=/usr/local/bin/gsed
else
    SED=`which sed`
fi
if [ -z ${SED} ]; then
    echo can not find 'sed'
    exit
fi

FILES="md2html.sh"
# filtering FILES is a good idea.
#FILES="*.lisp *.rb *.c"

# example, skip *.bak files
for i in ${FILES}; do
    if [ ./$i = $0 ]; then
        continue
    fi
    if [[ $i =~ bak$  ]]; then
        continue
    fi
    ${SED} -i.bak "s/VERSION: .*$/VERSION: ${VERSION}, ${TODAY}./" $i
done

# example of sed 'c' command.
#${SED} -i.bak "/(defvar \*version\*/ c\
#(defvar *version* \"${VERSION}\")" *.lisp

echo ${VERSION} > VERSION
