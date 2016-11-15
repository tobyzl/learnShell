#!/bin/sh
SAVEIFS=$IFS
IFS=$'\n'
echo "  \033[36m start creating mac_qrc \033[0m"
cd `dirname $0`
pad7_dir=../../PAD7

#function to create qrc_file 
fun_create_qrc() {
    local qrc_folder=$1
    local qrc_file=$2
    local project_name=$3/

    echo \<?xml version=\"1.0\" encoding=\"UTF-8\"?\> >> $qrc_file
    echo \<\!DOCTYPE RCC\> >> $qrc_file
    echo \<RCC\> >> $qrc_file  
    echo \<qresource prefix=\"/\"\> >> $qrc_file

    for qrc in `find ${qrc_folder} -name '*.png'` `find ${qrc_folder} -name '*.bmp'` `find ${qrc_folder} -name '*.qml'` `find ${qrc_folder} -name '*.xml'` `find ${qrc_folder} -name '*.jpg'`
    do
        qrc_dir=${qrc##*$project_name} 
        echo \<file\>$qrc_dir\</file\> >> $qrc_file
    done

    echo \</qresource\>>> $qrc_file
    echo \</RCC\>>> $qrc_file
}

#find all file which name is Projects
for projects_dir in `find ${pad7_dir} -name Projects`
do 
    #list all files in projects_dir
    for project_name in `ls ${projects_dir}`
    do    
        #find images qml widgets in all project_names
        form="qrc"
        for qrc_folder in images qml widgets
        do 
            #delete old qrc_file and create new qrc_file if qrc_folder exist
            if [ -e ${projects_dir}/${project_name}/${qrc_folder} ]; then 
                if [ -e ${projects_dir}/${project_name}/${project_name}.$form ]; then 
                    rm ${projects_dir}/${project_name}/${project_name}.$form
                fi
                touch ${projects_dir}/${project_name}/${project_name}.$form
                fun_create_qrc ${projects_dir}/${project_name}/${qrc_folder} ${projects_dir}/${project_name}/${project_name}.$form $project_name            
            fi
        done
    done
done

echo "  \033[32m create mac_qrc successfully \033[0m"

IFS=SAVEIFS
