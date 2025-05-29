TEMP=$(cat /sys/class/hwmon/hwmon5/temp1_input)
echo $((TEMP / 1000))
