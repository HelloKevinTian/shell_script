#!/bin/bash

#找出当前目录下小于200m的文件
find ./ -size -200M -exec du -h {} \;

#找出当前目录下大于200m的文件
find ./ -size +200M -exec du -h {} \;

#生成随机字符串
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1

#获取本机ip
ifconfig | grep "inet addr:" | awk '{ print $2 }'| sed 's/addr://g'

#搜索文件中的特定字符串内容
find . -name "*.log" | xargs grep "Error"