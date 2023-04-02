#!/usr/bin/sh
echo "### Starting experiment ###"

adb='/mnt/c/Users/salve/AppData/Local/Android/Sdk/platform-tools/adb.exe'

TASK_REPETITIONS=1 #20
IN_TASK_REPETITIONS=10 #5
BETWEEN_TASKS_PAUSE=60 #60

if [ $# -ge 1 ]
  then
    TASK_REPETITIONS=$1
fi

if [ $# -eq 2 ]
  then
    IN_TASK_REPETITIONS=$2
fi

echo "Task repetitions: $TASK_REPETITIONS"

clean_old_results() {
	rm batt*.txt 
	rm measures*
    rm ./time
}

clean_old_results

run_top() {
    echo "run number $1"
    $adb shell "top -bd1 -o res,%cpu,%mem,args -m 200 | grep com.example | grep -v grep" >> ./measures$1.txt
}

scroll_down() {
    max=3
    for i in `seq 1 $max`
    do
        $adb shell input swipe 580 2030 670 360
        sleep 1
    done
}

scroll_up(){
    max=3
    for i in `seq 1 $max`
    do
        $adb shell input swipe 670 360 580 2030
        sleep 1
    done
}

go_back() {
    $adb shell input tap 71 216
    sleep 1
}

tap_image() {
    $adb shell input tap 200 500
    sleep 1
}

run_task() {
    for i in `seq 1 $IN_TASK_REPETITIONS`
    do
        #open list tab
        $adb shell input tap 136 2260
        sleep 1
        
        #scroll the list
        scroll_down
        scroll_up
                
        #open input tab
        $adb shell input tap 560 2260
        sleep 1

        #compile the inputs
        $adb shell input tap 747 363
        sleep 1
        $adb shell input text "First"
        sleep 1
        $adb shell input tap 747 524
        sleep 1
        $adb shell input text "Second"
        sleep 1
        $adb shell input tap 747 670
        sleep 1
        $adb shell input text "Third"
        sleep 1

        #hide keyboard
        $adb shell input keyevent 111

        #clear inputs
        $adb shell input tap 498 914
        sleep 1

        #open image tab
        $adb shell input tap 890 2330
        sleep 1
        scroll_down
        scroll_up

        #open image screens
        $adb shell input tap 110 450
        sleep 1
        tap_image
        tap_image
        tap_image

        go_back

        $adb shell input tap 530 450
        sleep 1
        tap_image
        tap_image
        tap_image

        go_back

        $adb shell input tap 800 450
        sleep 1
        tap_image
        tap_image
        tap_image

        go_back

    done
}

start_date_sec=`date +%s`
start_date=`date`

for i in `seq 1 $TASK_REPETITIONS`
    do
    echo "### Starting run #$i ###"

    $adb shell am start -W -n \
        "com.example.master_thesis_flutter_app/com.example.master_thesis_flutter_app.MainActivity" \
        -a android.intent.action.MAIN \
        -c android.intent.category.LAUNCHER \
        > /dev/null
    sleep 2

    #open GUI screen
    $adb shell input tap 495 554
    sleep 1

    echo Starting charge counter: $($adb shell dumpsys battery | awk '/counter/ {print $3}') >> ./batt$i.txt
    echo Starting battery temperature: $($adb shell dumpsys battery | awk '/temperature/ {print $2}') >> ./batt$i.txt
    run_top $i &
    echo parent pid: $$
    echo child pid: $!
    start_sec=`date +%s`

    run_task

    end_sec=`date +%s`
    duration=$((end_sec-start_sec))
    echo "Task duration: $duration seconds"
    echo $duration > ./time
    ps
    kill $!
    ps
    echo End charge counter: $($adb shell dumpsys battery | awk '/counter/ {print $3}') >> ./batt$i.txt
    echo End battery temperature: $($adb shell dumpsys battery | awk '/temperature/ {print $2}') >> ./batt$i.txt
    
    $adb shell am force-stop com.example.master_thesis_flutter_app
    $adb shell pm clear com.example.master_thesis_flutter_app

    sleep $BETWEEN_TASKS_PAUSE
done

end_date=`date`
end_date_sec=`date +%s`

echo "Start date: $start_date"
echo "End date: $end_date"
echo "Run time: $((end_date_sec-start_date_sec)) seconds"

echo "End"

$adb shell input keyevent KEYCODE_POWER
