#!/usr/bin/sh
adb='/mnt/c/Users/salve/AppData/Local/Android/Sdk/platform-tools/adb.exe'

$adb shell input keyevent KEYCODE_POWER
battery=$($adb shell dumpsys battery | awk '/counter/ {print $3}')
echo Current Battery: $battery
while [ $battery -lt 4340000 ]
do
    battery=$($adb shell dumpsys battery | awk '/counter/ {print $3}')
    echo Current Battery: $battery
    sleep 5
    clear
done

temperature=$($adb shell dumpsys battery | awk '/temperature/ {print $2}')
echo Current temp: $temperature
while [ $temperature -gt 235 ]
do
    temperature=$($adb shell dumpsys battery | awk '/temperature/ {print $2}')
    echo Current temp: $temperature
    sleep 5
    clear
done

echo Cooled down
$adb shell input keyevent KEYCODE_POWER