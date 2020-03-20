#ps -ef | grep latte-dock | grep -v "grep" | awk '{print $2}' | xargs kill
#setsid latte-dock &

#sleep 30s

count=`ps -ef  | grep "/usr/bin/i3" | grep -v "grep" | wc -l`

if [ $count  -eq 0 ] ; then
	setsid latte-dock &
else
	ps -ef | grep latte-dock | grep -v "grep" | awk '{print $2}' | xargs kill
fi
