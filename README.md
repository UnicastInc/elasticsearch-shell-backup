Elasticsearch Backup Shell Script
==============================================

About
-------------

This scripts

Original script are provided by @karelbemelmans

- [Elasticsearch backup script with snapshot rotation · Karel Bemelmans](https://www.karelbemelmans.com/2015/03/elasticsearch-backup-script-with-snapshot-rotation/)

Our customized script replace URL to shell variable and split file with function.

Configuration
------------------------

### Shell variable

edit `shell-variables`

- `URL`: Elasticsearch base url
- `REPO`: Snapshot repository name
- `LIMIT`: Number of snapshots to keep

Requirements
------------------------

1. Elasticsearch 1.4, 5 maybe
1. curl
1. jq JSON Parser command

Usage
-----------------

call simply.

```
elasticsearch-backup-jobs.sh
```

This script simply execute `elasticsearch-take-snapshot.sh`, `elasticsearch-snapshot-rotation.sh` internally.

Schedule regular intervals
---------------------------------------

### cron

Most easist way to backup.

#### crontab

```
45 23 * * *    /etc/bacula/pre-backup.d/elasticsearch-backup-jobs.sh
```

or drop into `/etc/cron.{daily,weekly,monthly}` ...

### Bacula

Specify `bacula-dir.conf`.

```
Job {
  ClientRunBeforeJob = "/etc/bacula/pre-backup.d/elasticsearch-backup-jobs.sh"
}
```

### Another

- Jenkins, or another CIs.

For Test
---------------

### Take a snapshot

```
elasticsearch-take-snapshot.sh
```

### Rotate snapshots

```
elasticsearch-snapshot-rotation.sh
```

Tool commands
------------------------

### Get snapshot list

```
curl -X GET http://localhost:9200/_snapshot/es_backup/_all 2>/dev/null | jq -r '.snapshots [] .snapshot'
```

