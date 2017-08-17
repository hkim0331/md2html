#!/bin/sh
# https://github.com/hkim0331/md2html.git
# VERSION: 0.2

function usage()
{
  echo usage: $0 [--dest dir] file1.md file2.md ...
  exit 1
}

DEST="../public"

function md2html()
{
    TITLE=`basename $1 .md`
    HTML=${DEST}/${TITLE}.html

    pandoc  -o ${HTML} -f markdown -t html -c dummy.css $1
    gsed -i.bak \
    -e "/<head>/c\
<head>\n\
  <meta http-equiv='X-UA-Compatible' content='IE=edge' />\n\
  <meta name='viewport' content='width=device-width, initial-scale=1.0' />"\
    -e "s/<title><\/title>/<title>${TITLE}<\/title>/" \
    -e '/<link/c\
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">' \
    -e 's/<body>/<body><div class="container">/' \
    -e 's/<table>/<div class="table-responsive"><table class="table table-striped table-hover">/g' \
    -e 's/<\/table>/<\/table><\/div>/g' \
    -e 's/<\/body>/<\/div><\/body>/' \
    ${HTML}
}

while [ "$#" -ne "0"  ]; do
    if [ "$1" = "--help" ]; then
        usage;
    elif [ "$1" = "--dest" ]; then
        shift
        DEST=$1
    else
        md2html $1;
    fi
    shift
done

echo `date` > UPDATE
