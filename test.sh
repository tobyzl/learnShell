echo -e "\nThis is a script to find all the files in a specified path contains a keyword!" 
07. 
08.echo -e "\nPlease input a keyword:" 
09.read key 
10.if [ "$key" == "" ]; then 
11.    echo -e "keyword can not be null!\n" 
12.    exit 0 
13.fi 
14.keyword=$key 
15. 
16.echo -e "\nPlease input your specified path:" 
17.read dir 
18.#判断该路径是否存在，并且是目录，不存在输出提示 
19.test ! -d $dir && echo -e "The $dir is not exist in your system.\n\n" && exit 0 
20. 
21.echo -e "\n---------------You find files are:---------------\n" 
22. 
23.#keyword=JAVA_OPTS 
24.#dir=/jboss/jboss-eap-4.3/jboss-as/ 
25. 
26.#统计文件个数 
27.file_count=0 
28.#递归查看所有目录，即最深路径，不显示空行 
29.file_list=`ls -R $dir 2> /dev/null | grep -v '^$'` 
30.for file_name in $file_list 
31.do 
32.    #临时文件变量temp，将ls -R即file_list中的文件名中所有匹配:后接一个或多个任意字符（.代表任意字符，*代表0个或多个$代表行尾结束符）全局替换为无 
33.    #简单的说，就是把file_name变量中的匹配：的行，将：后内容替换为空 
34.    temp=`echo $file_name | sed 's/:.*$//g'` 
35.    #如果临时文件变量temp是一个目录，而非文件，就将该目录赋值给cur_dir变量 
36.    if [ "$file_name" != "$temp" ]; then 
37.        cur_dir=$temp 
38.        #echo "-"$cur_dir #临时显示，调试用 
39.    else 
40.        #用file命令查看文件真身是否为ASCII text类型 
41.        file_type=`file $cur_dir/$file_name | grep "text"` 
42.        if [ "$file_type" != "" ]; then 
43.            temp=`grep $keyword $cur_dir/$file_name 2> /dev/null` 
44.            #echo "--"$cur_dir/$file_name #临时显示，调试用 
45.            if [ "$temp" != "" ]; then 
46.                echo $cur_dir/$file_name 
47.                #文件个数加1 
48.                let file_count++ 
49.            fi 
50.        fi 
51.    fi 
52.done 
53. 
54.echo -e "\n-------------------------------------------------" 
55.echo -e "\n\nFiles Total: $file_count" 
56.echo -e "\nFind Finished!\n"
