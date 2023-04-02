#!/usr/bin/sh
echo "### Starting experiment ###"

adb='/mnt/c/Users/salve/AppData/Local/Android/Sdk/platform-tools/adb.exe'

take-screenshot() {
        $adb shell screencap -p /sdcard/image.png
        $adb pull /sdcard/image.png ./image.png
}

clean_old_results() {
        rm batt*.txt 
        rm measures*
        rm ./time
        rm ./image.png
}

clean_old_results

run_top() {
        echo "run number $1"
        $adb shell "top -bd1 -o res,%cpu,%mem,args -m 200 | grep com.rnartifact | grep -v grep" >> ./measures1.txt
}

$adb shell settings put system screen_brightness 256
start_date_sec=`date +%s`
start_date=`date`

echo "### Starting computation ###"

$adb shell monkey -p com.rnartifact 1
sleep 2

#open CPU screen
$adb shell input tap 300 345
sleep 1

echo Starting charge counter: $($adb shell dumpsys battery | awk '/counter/ {print $3}') >> ./batt1.txt
echo Starting battery temperature: $($adb shell dumpsys battery | awk '/temperature/ {print $2}') >> ./batt1.txt
run_top $i &
echo parent pid: $$
echo child pid: $!
start_sec=`date +%s`

#start task
$adb shell input tap 300 360

sleep 600

$adb shell input tap 300 450

end_sec=`date +%s`
duration=$((end_sec-start_sec))
echo "Task duration: $duration seconds"
echo $duration > ./time
ps
kill $!
ps
echo End charge counter: $($adb shell dumpsys battery | awk '/counter/ {print $3}') >> ./batt3.txt
echo End battery temperature: $($adb shell dumpsys battery | awk '/temperature/ {print $2}') >> ./batt3.txt

take-screenshot
$adb shell am force-stop com.rnartifact
$adb shell pm clear com.rnartifact

end_date=`date`
end_date_sec=`date +%s`

echo "Start date: $start_date"
echo "End date: $end_date"
echo "Run time: $((end_date_sec-start_date_sec)) seconds"

echo "End"

$adb shell input keyevent KEYCODE_POWER
