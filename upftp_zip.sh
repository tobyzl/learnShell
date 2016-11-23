#!/bin/sh
ftp -n<<!
open 192.168.50.55
user pad pad

mkdir "/test/PADSystem V7/MAC/$(date '+%Y%m%d')"
binary
cd "/test/PADSystem V7/MAC/$(date '+%Y%m%d')"
lcd "../build/zip_files"
prompt
mput *

close
bye



