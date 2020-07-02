#!/bin/bash

cd /usr/local/filebeat7.8.0/

nohup /usr/local/filebeat7.8.0/filebeat -e  -c /Users/tianwen/work/etc/filebeat/filebeat.yml -path.home /usr/local/filebeat7.8.0 -path.config /Users/tianwen/work/etc/filebeat &

ps x|grep 'filebeat'