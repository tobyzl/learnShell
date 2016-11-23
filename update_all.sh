#!/bin/sh

echo '\033[32m [----------------------------Start update-----------------------------] \033[0m'

cd `dirname $0`;
cd ../../../PADGit/PAD7

git fetch --all
git reset --hard origin/master

cd ./Tools
sh mac_create_qrc.sh

exit 0

