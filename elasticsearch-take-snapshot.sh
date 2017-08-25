#!/bin/bash

base_dir="$(dirname "$0")"
source $base_dir/shell-variables

curl -XPUT "$URL/_snapshot/$REPO/$SNAPSHOT?wait_for_completion=true" | jq '.'

