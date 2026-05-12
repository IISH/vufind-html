#!/bin/bash

source /etc/environment

DB_HOST="${DB_HOST}"
DB_USER="${DB_USER}"
DB_PASS="${DB_PASS}"

email="$1"

sql="select id from user WHERE email='${email}';"
user_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -BN -e "$sql" vufind)
[ -z "$user_id" ] && echo "Not found ${email}" && exit 1

sql="select resource_id FROM user_resource WHERE user_id=${user_id} ;"
f="resource-id-${user_id}"

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -BN -e "$sql" vufind > "$f"

while read -r resource_id
do
  sql="select record_id, title, author, year FROM resource WHERE id=${resource_id}"
  IFS=$'\t' read -r record_id title author year <<< "$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -NB -e "$sql" vufind)"
  echo "https://search.iisg.amsterdam/Record/${record_id} ${title} ${author} ${year}"
done < "$f"