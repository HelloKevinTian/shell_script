#!/bin/bash

#单表导出
mongoexport -h mongodb01.nuclearport.com:27000 -d pandora_console -c newadassets -o /Users/tianwen/work/data/pandora_console/newadassets.json