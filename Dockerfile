FROM postgres:9.4.6

RUN apt-get update && apt-get -y install wget ca-certificates s3cmd cron rsyslog

RUN touch /var/log/cron.log

ADD s3cfg /root/.s3cfg
ADD *.sh /root/
ADD rsyslog.conf /etc/
RUN chmod 0644 /etc/rsyslog.conf

ADD crontab /var/spool/cron/crontabs/root
RUN chmod 0600 /var/spool/cron/crontabs/root

RUN echo $PG_S3_BACKUP_PASSWORD > /root/.pgpass
RUN chmod 0600 /root/.pgpass

# Clean up after package manager
RUN rm -rf /var/lib/apt/lists/*

# Run rsyslogd as that's how cron writes logs. Then save the environment to a file to load in the cron job,
# because cron by default runs jobs with a minimal environment and we want to include the passed in docker 
# environment variables. Then just listen on the logs for changes.
CMD rsyslogd && cron && env > /root/env.sh && tail -f /var/log/syslog /var/log/cron.log
