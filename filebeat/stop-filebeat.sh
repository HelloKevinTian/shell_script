#!/bin/bash

kill $(ps x|grep 'filebeat'|awk '{print $1}')

ps x|grep 'filebeat'