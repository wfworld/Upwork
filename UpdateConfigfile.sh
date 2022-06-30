#!/bin/bash

#check the file
if [ ! -a appsettings.json ]
then
	touch appsettings.json
fi
if [ ! -a web.config ]
then
	touch web.config
fi

#append version info to config files - appsettings.json and web.config

#change appsettings.json
cur_time=$(date "+%Y.%m.%d")
curVersion=${cur_time}'.1'
initialVersion='{\n"version": "'${curVersion}'"\n}'

perVersion=$(sed -n  '/\"version\"/ p' appsettings.json)


if [[ ${#perVersion} -gt 10 ]]
then
{
	if([[ $perVersion =~ $cur_time ]])
	then
		{
		tmp=${perVersion##*\.}
		perInternalVersion=${tmp%\"*}
		curInternalVerion="$(($perInternalVersion + 1))"
		curVersion=${cur_time}'.'${curInternalVerion}
		echo $curVersion
		sed -i 's#\("version": "\).*#\1'"$curVersion"'"#g' appsettings.json
		}
	else
		{
		curVersion=${cur_time}'.1'
		echo $curVersion
		sed -i 's#\("version": "\).*#\1'"$curVersion"'"#g' appsettings.json
		}
	fi
}
else
	echo "initial"
	echo -e $initialVersion > appsettings.json
fi




#change web.config
cur_time=$(date "+%Y.%m.%d")
curVersion=${cur_time}'.1'
initialVersion='{\n"version": "'${curVersion}'"\n}'

perVersion=$(sed -n  '/\"version\"/ p' web.config)


if [[ ${#perVersion} -gt 10 ]]
then
{
	if([[ $perVersion =~ $cur_time ]])
	then
		{
		tmp=${perVersion##*\.}
		perInternalVersion=${tmp%\"*}
		curInternalVerion="$(($perInternalVersion + 1))"
		curVersion=${cur_time}'.'${curInternalVerion}
		echo $curVersion
		sed -i 's#\("version": "\).*#\1'"$curVersion"'"#g' web.config
		}
	else
		{
		curVersion=${cur_time}'.1'
		echo $curVersion
		sed -i 's#\("version": "\).*#\1'"$curVersion"'"#g' web.config
		}
	fi
}
else
	echo "initial"
	echo -e $initialVersion > web.config
fi


