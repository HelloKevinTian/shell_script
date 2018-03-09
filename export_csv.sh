#!/bin/bash
cd /share/temp/json2csv/s1

function getdir(){
    for element in `ls`
    do  
        dir_or_file=$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            echo $dir_or_file
            json2csv -i $dir_or_file -f gameUserId,money,level,stage,shopType,shopItemId,time,userHasAcquired  -o ${dir_or_file}".csv"
        fi  
    done
}

getdir