num1=100
num2=200

if test ${num1} -eq ${num2} 
then
	echo "eq"
else
	echo "not eq"
fi


str1="string"
str2="string"

if test ${str1} = ${str2} 
then
	echo "eq"
else
	echo "not eq"
fi


#judge is file exist
if test -e color.sh
then
    echo "exist"
else
	echo "not exist"
fi