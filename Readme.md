## docker-backup-postgresql-to-ftp

    A docker image with the ruby backup gem that is used to backup a postgresql container, upload it to ftp and notify slack if it fails

##### Usage

```
docker run --rm -i \
-e DATABASE_NAME=DBName \
-e DATABASE_USERNAME=Username
-e DATABASE_PASSWORD=Password \
-e FTP_USERNAME=FTP_USER \
-e FTP_PASSWORD=FTP_PASS \
-e FTP_IP=FTP_IP \
-e FTP_PATH=Path \
-e BACKUP_NAME='My Awesome Backup'
-e SLACK_URL='https://hooks.slack.com/services/XXXXXXXXXX' \
--link NAME_DB_PGCONTAINER:db \
steffenmllr/backup
```

