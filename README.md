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

1. Elasticsearch 1.4, 2, 5 maybe
1. curl
1. jq JSON Parser command

Usage
-----------------

clone scripts your preferred directory. In this case we assume cloned `/etc/bacula/pre-backup.d`.

```
git clone https://github.com/UnicastInc/elasticsearch-shell-backup.git /etc/bacula/pre-backup.d
```

call simply.

```
elasticsearch-backup-jobs.sh
```

This script simply execute `elasticsearch-take-snapshot.sh`, `elasticsearch-snapshot-rotation.sh` internally.

Schedule regular intervals
---------------------------------------

### cron

Most easiest way to backup.

#### crontab

```
45 23 * * *    /etc/bacula/pre-backup.d/elasticsearch-backup-jobs.sh
```

or drop into `/etc/cron.{daily,weekly,monthly}` ...

### Bacula

Specify in `bacula-dir.conf`.

```
Job {
  ClientRunBeforeJob = "/etc/bacula/pre-backup.d/elasticsearch-backup-jobs.sh"
}
```

Bacula File Daemon side, create `/etc/bacula/pre-backup.d/elasticsearch-backup-jobs.sh`

```bash
#!/bin/bash

# Elasticsearch snapshot lifecycle
/etc/bacula/pre-backup.d/elasticsearch-backup-jobs.sh
```

### Another

- Jenkins, GitLab CI or another CIs.

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

Hardening Security
------------------------------------------

```bash
chmod 700 /etc/bacula/pre-backup.d
chmod 600 shell-variables
```

Tool commands
------------------------

### Get snapshot list

```
curl -X GET http://localhost:9200/_snapshot/es_backup/_all 2>/dev/null | jq -r '.snapshots [] .snapshot'
```

