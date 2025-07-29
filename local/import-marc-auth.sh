#!/bin/bash

java \
  -Xms1g \
  -Xmx1g \
  -XX:+UseParallelGC \
  -XX:+AggressiveOpts \
  -DentityExpansionLimit=0 \
  -Djavax.net.ssl.trustStorePassword=changeit \
  -Djavax.net.ssl.trustStore=/opt/truststore.jks \
  -Duser.timezone=UTC \
  -Dsolr.core.name=authority \
  -Dsolr.indexer.properties=/var/www/vufind/local/import/import_iish.evergreen.authorities.properties \
  -jar \
  /var/www/vufind/import/SolrMarc.jar \
  /var/www/vufind/import/import_auth.properties \
  /data/datasets/iish.evergreen.authority/catalog.xml

 curl -X GET 'http://localhost:8080/solr/authority/update?optimize=true&commit=true'