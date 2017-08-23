#!/bin/bash
#
# Clean up script for old elasticsearch snapshots.
# 23/2/2014 karel@narfum.eu
#
# You need the jq binary:
# - yum install jq
# - apt-get install jq
# - or download from http://stedolan.github.io/jq/

# The amount of snapshots we want to keep.
LIMIT=30
# For test
#LIMIT=3

# Name of our snapshot repository
REPO=es_backup

# URL
URL=http://localhost:9200

# Get a list of snapshots that we want to delete
echo "curl -s -XGET \"$URL/_snapshot/$REPO/_all\" | jq -r \".snapshots[:-${LIMIT}][].snapshot\""
SNAPSHOTS=`curl -s -XGET "$URL/_snapshot/$REPO/_all" | jq -r ".snapshots[:-${LIMIT}][].snapshot"`

echo Snapshot List:
echo $SNAPSHOTS

# Loop over the results and delete each snapshot
for SNAPSHOT in $SNAPSHOTS
do
  echo "Deleting snapshot: $SNAPSHOT"
  curl -s -XDELETE "$URL/_snapshot/$REPO/$SNAPSHOT?pretty" | jq '.'
  if [ "$?" != "0" ]; then
    echo Could not delete $SNAPSHOT.
  fi
done
echo "Done!"

