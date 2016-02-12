# encoding: utf-8
require 'slack-notifier'

Model.new(:backup, ENV['BACKUP_NAME'].dup) do

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV['DATABASE_NAME'].dup
    db.username           = ENV['DATABASE_USERNAME'].dup
    db.password           = ENV['DATABASE_PASSWORD'].dup
    db.host               = ENV['DB_PORT_5432_TCP_ADDR'].dup
    db.port               = ENV['DB_PORT_5432_TCP_PORT'].dup
  end

  ##
  # SFTP (Secure File Transfer Protocol) [Storage]
  #
  store_with SFTP do |server|
    server.username   = ENV['FTP_USERNAME'].dup
    server.password   = ENV['FTP_PASSWORD'].dup
    server.ip         = ENV['FTP_IP'].dup
    server.path       = ENV['FTP_PATH'].dup
    server.keep       = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip


  after do |exit_status|
    notifier = Slack::Notifier.new ENV['SLACK_URL'].dup
    if exit_status != 0
      attachment = {
        fallback: "Backup Status FAILURE",
        text: "Backup for #{ENV['BACKUP_NAME'].dup} did not work!!",
        color: "#ff0000"
      }
      notifier.ping "Backup Status #{ENV['BACKUP_NAME'].dup}", attachments: [attachment]
    end

  end

end
