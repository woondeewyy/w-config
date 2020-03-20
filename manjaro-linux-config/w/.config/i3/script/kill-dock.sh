#ps -ef | grep latte-dock | grep -v "grep" | awk '{print $2}' | xargs kill
#setsid latte-dock &

sleep 6s
ps -ef | grep latte-dock | grep -v "grep" | awk '{print $2}' | xargs kill
