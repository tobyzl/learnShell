name="zl"
echo $name
echo ${name}

for skill in ada coffe acion java
do
	echo "I am good at ${skill}Script"
done

name="zhang"
echo ${name}

num=1
readonly num
#this variable is read only
#num=2

unset name
echo "unset name"
echo ${name}

n=2
readonly n
echo ${n}
#unset n
#echo "unset n"
echo ${n}


#shell string
str='this is a strig'
#单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
#单引号字串中不能出现单引号（对单引号使用转义符后也不行）。
name="zl"
str="name is \"${name}\""
#双引号里可以有变量
#双引号里可以出现转义字符

#拼接字符串 
greeting="hello, "$name"!"
greet="hello, ${name}!"
echo ${greeting} 
echo ${greet}


#获取字符串长度 
string="abcd"
echo ${#string}

#提取子字符串
string="runoob is a great site"
#echo ${string:1:4}
echo `expr index "$string" is`

