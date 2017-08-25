#!/bin/bash

base_dir="$(dirname "$0")"
source $base_dir/shell-variables

$base_dir/elasticsearch-take-snapshot.sh
$base_dir/elasticsearch-snapshot-rotation.sh

