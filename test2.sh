#!/bin/bash  

 
if [ 'x' == 'x'$1 ]; then  
    echo "Usage $0 search_dir"  
   exit  
fi  

dir_arr=$(find $1 -type d -print;)  
store_path="/tmp/1.txt"  
if [ -f $store_path ]; then  
    rm -r $store_path  
fi  
 
for dir in ${dir_arr[*]}  
do  
   find $dir -type f >>$store_path  
done  

for file in $(awk -F '/' '{print $NF}' $store_path  | sort | uniq -d)  
do  
    echo $file  
done  
