#!/bin/sh
echo it is a test
echo "it is a test"

echo "\" it is a test \""

echo "input:"
read name
echo "$name is inputed"

echo "switch \n"
echo "switch"
echo "don't switch \c"
echo "don't switch"

echo "write file" > myfile

#output string as it is
echo '$name \"' 

#output order result
echo `date`