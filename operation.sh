#!/bin/bash

va1=`expr 2 + 2`
echo ${va1}

a=10
b=20

va1=`expr $a + $b`
echo "a + b : $va1"

va1=`expr $a - $b`
echo "a - b : $va1"

va1=`expr $a \* $b`
echo "a * b : $va1"

va1=`expr $a / $b`
echo "a / b : $va1"

va1=`expr $a % $b`
echo "a % b : $va1"


if [ $a != $b ] 
then 
    echo "a != b"
fi

#if [ $a == $b ] 
#then
#    echo "a == b"
#fi

if [ -r $myfile ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $myfile ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $myfile ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $myfile ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $myfile ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $myfile ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $myfile ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n $a ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi



a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi