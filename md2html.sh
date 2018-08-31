#!/bin/sh
# https://github.com/hkim0331/md2html.git
# VERSION: 0.2
#
# 2018-08-31 Bootstrap 4.1.3

if [ "$#" = "0" ]; then
  echo usage: $0 file1.md file2.md ...
  exit 1
fi

md2html()
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">' \
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
