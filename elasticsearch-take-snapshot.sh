#!/bin/bash
SNAPSHOT=`date +%Y%m%d-%H%M%S`
REPO=es_backup
URL=http://localhost:9200
curl -XPUT "$URL/_snapshot/$REPO/$SNAPSHOT?wait_for_completion=true" | jq '.'

