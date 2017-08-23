#!/bin/bash

/etc/bacula/pre-backup.d/elasticsearch-take-snapshot.sh
/etc/bacula/pre-backup.d/elasticsearch-snapshot-rotation.sh

