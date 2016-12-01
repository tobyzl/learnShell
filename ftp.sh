#from ftp /home/data to local /home/databackup

#£¡/bin/bash

ftp -n<<!
open 192.168.1.171
user username password
binary
cd /home/data
lcd /home/databackup
prompt

#load all file
mget *.mp3

#upload all file
mput *

# load a file
get a.txt [new_name.txt]

#upload a file
put a.txt [new_name.txt]

close
bye
!


