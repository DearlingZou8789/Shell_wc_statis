# !/bin/bash

# 默认目录黑名单
Default_Directory_Blackspace=( '*.framework' 'ObjcUML' )
# 默认统计文件扩展名
Default_File_Extension=( '*.h' '*.m' '*.c' '*.hpp' '*.cpp' )

count=$((${#Default_Directory_Blackspace[@]} - 1))
echo $count
for d in $(ls $1); do
    for i in $(seq 0 $count); do
    	d=${Default_Directory_Blackspace[$i]}
        echo Number of digits at the beginning of \"$d\" is $b
    done
done

