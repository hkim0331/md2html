#!/bin/sh
# https://github.com/hkim0331/md2html.git
# VERSION: 0.1

if [ "$#" = "0" ]; then
  echo usage: $0 file1.md file2.md ...
  exit 1
fi

function md2html()
{
    TITLE=`basename $1 .md`
    HTML=../public/${TITLE}.html

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

while (( "$#" )); do
    md2html $1;
    shift
done

echo `date` > UPDATE
