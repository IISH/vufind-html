#!/bin/bash
#
# iish.archieven.sh
#
# Invoke fop to create PDF files


pdf_folder="${VUFIND_CACHE_CACHE_DIR}/pdf"
for file in "$pdf_folder"/ARCH*.xml "$pdf_folder"/COLL*.xml
do
    filename=$(basename $file)
    pdf="${pdf_folder}/${filename:0:9}.pdf"
    echo "Creating $pdf from $file"
    /usr/bin/fop -c /usr/local/vufind/local/import/fop/fop.xconf -xml $file -xsl /usr/local/vufind/local/import/fop/xsl/iish.archieven/ead_complete_fo.xsl -pdf $pdf -param path /usr/local/vufind/local/import/fop/xsl/iish.archieven -param sysYear $(date +'%Y')
    if [ -f "$pdf" ] ; then
        chmod 444 "$pdf"
    fi
    rm $file
done