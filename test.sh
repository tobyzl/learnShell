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
18.#�жϸ�·���Ƿ���ڣ�������Ŀ¼�������������ʾ 
19.test ! -d $dir && echo -e "The $dir is not exist in your system.\n\n" && exit 0 
20. 
21.echo -e "\n---------------You find files are:---------------\n" 
22. 
23.#keyword=JAVA_OPTS 
24.#dir=/jboss/jboss-eap-4.3/jboss-as/ 
25. 
26.#ͳ���ļ����� 
27.file_count=0 
28.#�ݹ�鿴����Ŀ¼��������·��������ʾ���� 
29.file_list=`ls -R $dir 2> /dev/null | grep -v '^$'` 
30.for file_name in $file_list 
31.do 
32.    #��ʱ�ļ�����temp����ls -R��file_list�е��ļ���������ƥ��:���һ�����������ַ���.���������ַ���*����0������$������β��������ȫ���滻Ϊ�� 
33.    #�򵥵�˵�����ǰ�file_name�����е�ƥ�䣺���У������������滻Ϊ�� 
34.    temp=`echo $file_name | sed 's/:.*$//g'` 
35.    #�����ʱ�ļ�����temp��һ��Ŀ¼�������ļ����ͽ���Ŀ¼��ֵ��cur_dir���� 
36.    if [ "$file_name" != "$temp" ]; then 
37.        cur_dir=$temp 
38.        #echo "-"$cur_dir #��ʱ��ʾ�������� 
39.    else 
40.        #��file����鿴�ļ������Ƿ�ΪASCII text���� 
41.        file_type=`file $cur_dir/$file_name | grep "text"` 
42.        if [ "$file_type" != "" ]; then 
43.            temp=`grep $keyword $cur_dir/$file_name 2> /dev/null` 
44.            #echo "--"$cur_dir/$file_name #��ʱ��ʾ�������� 
45.            if [ "$temp" != "" ]; then 
46.                echo $cur_dir/$file_name 
47.                #�ļ�������1 
48.                let file_count++ 
49.            fi 
50.        fi 
51.    fi 
52.done 
53. 
54.echo -e "\n-------------------------------------------------" 
55.echo -e "\n\nFiles Total: $file_count" 
56.echo -e "\nFind Finished!\n"
