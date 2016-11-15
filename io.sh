#rewrite
echo "new" > myfile
#add something at the end
echo "end" >> myfile 

wc -l < myfile
wc -l myfile