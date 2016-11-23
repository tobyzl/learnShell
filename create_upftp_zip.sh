#!/bin/sh
OLDIFS=$IFS
IFS=$'\n'

echo "\033[35m create zip_files \033[0m"
cd `dirname $0`
cd ../build

make_zip_file() {
    if test -e ./zip_files
    then
       rm -rf zip_files
    fi
    mkdir zip_files
      
    form="zip"
    for file in `find . -name "*.mpkg"`
    do
        echo "  \033[35m create ${file}.zip \033[0m"
        file_name=$(echo $file | tr ' ' '_')
        tar -zcf zip_files/${file_name}.${form} ./${file}
    done
}

make_zip_file

echo "\033[35m upftp zip_files \033[0m"
sh ../Tools/upftp_zip.sh

IFS=$OLDIFS
