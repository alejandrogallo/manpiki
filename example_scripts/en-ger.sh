#! /usr/bin/env bash

word=$1
dic="fd-eng-deu"

dict -d ${dic} ${word} | sed "
/^$/d
/1 definition found/d
/fd.eng.deu/d
"
