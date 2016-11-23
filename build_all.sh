#!/bin/sh
echo '\033[36m [--------------------------------Start Build------------------------------] \033[0m'

#===================================
cd `dirname $0`; pwd

cd ..
cd ..
cd ..
pro_name=${PWD}/PADGit/PAD7

qmake=/Applications/Develop/Qt5.4.0/5.4/clang_64/bin/qmake

echo '  \033[36m [--------------------------------Remove Makefile------------------------------] \033[0m'
find ${pro_name} -name "Makefile" -exec /bin/rm -f '{}' +

echo '  \033[36m [--------------------------------Build------------------------------] \033[0m'
cd ${pro_name}

echo '  \033[36m [----------------------------Remove PAD build directory--------------------------] \033[0m'
rm -Rf build
$qmake "CONFIG+=release" ${pro_name}/PadSystem.pro
make

echo '  \033[36m [----------------------------build success--------------------------] \033[0m'
exit 0