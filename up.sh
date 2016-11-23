#!/bin/sh
ftp -n<<!
open 192.168.50.55
user pad pad

mkdir "/test/PADSystem V7/MAC/sh"
binary
cd "/test/PADSystem V7/MAC/sh"
lcd "./"
prompt
mput *

close
bye



