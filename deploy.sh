#!/bin/bash

URL='https://github.com/IISH/vufind-html/archive/refs/heads/'

branch="$1"

[ -z "$branch" ] && echo "Need the name of the branch to place after in ${URL}" && exit 1

filename="${branch}.zip"
url="${URL}/${filename}" # e.g. wget https://github.com/IISH/vufind-html/archive/refs/heads/TCI-10808.zip
wget "$url" -O "$filename"
unzip "$filename"

foldername="vufind-html-${branch}"
[ ! -d "$foldername" ] && echo "Expected folder not found: ${foldername}" && exit 1

rsync -av ${foldername}/ /var/www/vufind/

echo 'Cleanup and start again...'
/opt/cleanup.sh

echo 'Done with update.'