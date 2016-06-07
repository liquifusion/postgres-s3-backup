# postgres-s3-backup

Backup PostgreSQL to Amazon S3 using `pg_dump` within a Dockerized container.

It expects the following environment variables to be set:

-  `PG_S3_BACKUP_BUCKET` - S3 bucket to use backup storage
-  `PG_S3_BACKUP_ACCESS_KEY` - AWS access key to authorize writing to the bucket
-  `PG_S3_BACKUP_SECRET_KEY` - AWS secret key to authorize writing to the bucket
-  `PG_S3_BACKUP_HOST` - Host of database to backup
-  `PG_S3_BACKUP_USER` - User of database to backup
-  `PG_S3_BACKUP_PASSWORD` - Password used to login as `PG_S3_BACKUP_USER`
-  `PG_S3_BACKUP_DB` - Name of database to backup

Then schedule your hosting to run this command within the container at an interval of your choosing:

```
sh /root/db_backup.sh
```

## Configuring the container to do Cron itself

The `Dockerfile` also contains an optional Dockerized cron job that runs the backup every day at midnight. Just
un-comment the last `CMD` statement in the `Dockerfile` if you want for the container to handle the Cron itself
without intervention from external hosting.
