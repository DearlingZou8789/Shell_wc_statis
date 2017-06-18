# Shell_wc_statis
Number of rows in statistical items and words

####  说明
本项目主要是用于工程文件统计，由于本人是iOS开发人员，需要统计项目中现有代码行数，加上由于本人喜爱脚本语言，故而有此项目.本项目主要文件是wc_statis.sh，其他文件为学习shell脚本时使用的demo。项目中有配置[黑名单目录]和[统计的文件类型],也可以使用默认的参数，那是我的项目中的默认配置

####	使用
``` Shell
	./wc_statis.sh 项目目录(绝对路径/相对路径)
```
如果./wc_statis.sh没有权限，使用```chmod +x wc_statis.sh```进行操作

####	后续
后期添加getopts进行参数设置。[黑名单目录]和[统计的文件类型]通过参数进行设置。