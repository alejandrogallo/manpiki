#! /usr/bin/env bash

function header()   { echo -e "\n\033[1m$@\033[0m"; }
function success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

####################################
#  Rough script to create a build  #
####################################

SRC_DIR=../src
BUILD_DIR=../dist
VIEWER="${SRC_DIR}/index.html"
BUILD_VIEWER="${BUILD_DIR}/manpiki.html"

mkdir -p ${BUILD_DIR}

header "Examining $VIEWER..."
js_files=$(cat $VIEWER | grep "<script" | grep src | sed -e "s/.*src=\"\(\S*\)\".*/\1/")
css_files=$(cat $VIEWER | grep "<link" | grep href | sed -e "s/.*href=\"\(\S*\)\".*/\1/")


header "Creating new viewer in $BUILD_VIEWER "
cat $VIEWER | sed -e "/script.*src.*/d" -e "/<\/body/d" -e "/<\/html/d" > $BUILD_VIEWER

header "CSS files"
for fileName in $css_files; do
  arrow "Parsing \033[0;31m\033[0m $fileName"

  if [ ! -f ${SRC_DIR}/$fileName ]; then
    error "File $fileName not found"
    continue
  fi

  sed -i  "\:${fileName}:{ 
i <style type='text/css' media='screen'>
r ${SRC_DIR}/${fileName}
a </style>
d
}" ${BUILD_VIEWER}

done

header "JS files"
for fileName in $js_files; do

  arrow "Parsing file $fileName"

  if [ ! -f ${SRC_DIR}/$fileName ]; then
    error "File $fileName not found"
    continue
  fi

  cat >> $BUILD_VIEWER <<EOF
  <script>
  $(cat ${SRC_DIR}/$fileName)
  </script>
EOF
done

echo "</body></html>" >> $BUILD_VIEWER

