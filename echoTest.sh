# !/bin/bash

tmplog="echoTest.log"
echo "Start">tmplog
echoHello(){
	echo "Hello" >> $tmplog
	value=$(wc $1)
	echo $value
	echo "$value" >> $tmplog
	echo "This is end\n" >> $tmplog
}

for i in `seq 9`; do
	echoHello $1
done

