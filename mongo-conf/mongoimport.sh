#!/bin/bash

#单表导入
mongoimport -h 127.0.0.1:27000 -d pandora -c newadassets /Users/tianwen/work/data/pandora_console/newadassets.json