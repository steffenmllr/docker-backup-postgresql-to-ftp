FROM ruby:1.9

MAINTAINER Steffen Müller <steffen@mllrsohn.com>

RUN apt-get -y -q update && apt-get -y -q install postgresql-9.4
RUN gem install backup -v 3.11.0 --no-rdoc --no-ri && gem install slack-notifier --no-rdoc --no-ri
RUN backup generate:model --trigger backup --databases='postgresql' --storages='ftp'

COPY config.rb /root/Backup/models/backup.rb

CMD ["backup", "perform", "--trigger", "backup"]
