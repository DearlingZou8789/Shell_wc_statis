# !/bin/bash

##### 判断参数 ####
if [ $# -lt 1 ]; then
    echo "Error! 参数必须不小于1"
    exit 2
fi

if [ ! -d $1 ]; then
    echo "Error, 第一个参数必须为目录"
    exit 2
fi

########	配置项	#######
# 默认目录黑名单
Default_Directory_Blackspace=('*.framework' 'ObjcUML' 'Pods' 'ThirdPart')
# 默认统计文件扩展名
Default_File_Extension=('*.h' '*.m' '*.c' '*.hpp' '*.cpp')

#######		End		######

# 获取目录名，创建文件
directoryName=$(basename $1)
pwdPath=`pwd`
# 在当前目录下创建记录文件
tmpLog="$pwdPath/$directoryName.log"
uniqTmpLog="$pwdPath/$directoryName_uniq.log"
echo "">$tmpLog

# 统计目录
function isBlackDirectory() {
	index=0
	count=${#Default_Directory_Blackspace[@]}
	result=1
	diranme=`basename $1`
	while [ "$index" -lt "$count" ]; do
		compare="${Default_Directory_Blackspace[$index]}"
		if [[ $diranme == $compare ]]; then
			result=0
		fi
		let "index += 1"
	done
	echo $result
	return
}

# 其实已经在statisMain中替换掉了
function statisDirectory() {
	result=$( isBlackDirectory $1 )
	if [[ result ]]; then
		statisMain $1
	fi
} 

# 统计文件
function isDefaultExtension() {
	index=0
	count=${#Default_File_Extension[@]}
	declare -i result=0
	diranme=`basename $1`
	while [ "$index" -lt "$count" ]; do
		compare="${Default_File_Extension[$index]}"
		if [[ $diranme == $compare ]]; then
			result=1
		fi
		let "index += 1"
	done
	echo $result
}

function statisFile() {
	result=$(isDefaultExtension $1)
	if [[ $result == 1 ]]; then
		value=$( wc $1 )
	fi
	echo $value
	echo $value >> $tmpLog
}

# 统计函数
function statisMain() {
	for d in $(ls $1); do
		if [[ $1 == "." ]]; then
			subD=$d
		else
			subD="$1/$d"
		fi
		if [[ -d $subD ]] && [[ $(isBlackDirectory $subD) == 1 ]]; then
			statisMain $subD
		elif [[ -f $subD ]] ; then
			statisFile $subD
		fi
	done
}

# cd $project_path
# 工程绝对路径
cd $1
project_path='.'
statisMain $project_path

# 去掉重复，不知道为什么会出现
uniq $tmpLog > $uniqTmpLog
rm $tmpLog
mv $uniqTmpLog $tmpLog

# 目前$tmplog中的文件格式为 
# 行数	单词数	字节数	文件名
# 统计行数，单词数，字节数
statisValue=`awk 'BEGIN {count1=0;count2=0;count3=0; print "[start] lines words bytes "} {count1=count1+$1; count2=count2+$2; count3=count3+$3;} END{printf("[total] %d %d %d", count1, count2, count3)}' $tmpLog`
echo $statisValue
echo $statisValue 1>>$tmpLog