#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com

my_array=(1 2 3 4)

echo "第一个元素为: ${my_array[0]}"
echo "第二个元素为: ${my_array[1]}"
echo "第三个元素为: ${my_array[2]}"
echo "第四个元素为: ${my_array[3]}"

echo "all : ${my_array[*]}"
echo "all : ${my_array[@]}"

echo "all : ${#my_array[*]}"
echo "all : ${#my_array[@]}"


