#!/bin/bash
#
# make.sh
#
# Build a package

composer --working-dir=. install
npm install --production
mv ./node_modules/ ./themes/iish/vendor/
php ./util/cssBuilder.php iish
