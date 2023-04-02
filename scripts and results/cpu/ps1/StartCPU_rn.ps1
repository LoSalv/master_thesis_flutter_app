echo "### Starting experiment ###"

function Take-Screenshot {
    param ($i)
    adb shell screencap -p /sdcard/image.png
    adb pull /sdcard/image.png .\image$i.png
}

adb shell dumpsys procstats --clear
adb shell settings put system screen_brightness 1
$startDate = Get-Date

For ($i = 0; $i -lt 15; $i++) {
    echo "### Starting run #$i ###"

    #adb shell dumpsys batterystats --reset
    adb shell monkey -p com.rnartifact 1
    sleep 3
    adb shell input tap 294 686
    sleep 2 

    #run task
    adb shell dumpsys battery | Select-String "Charge Counter"
    adb shell input tap 87 337

    #run multi task
    # adb shell input tap 596 480
    sleep 300
    adb shell dumpsys battery | Select-String "Charge Counter"
    adb shell dumpsys battery | Select-String "temperature"

    Take-Screenshot $i
    adb shell am force-stop com.rnartifact
    adb shell pm clear com.rnartifact

    sleep 600

}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"

adb shell dumpsys procstats --hours 6 lord.app.com
adb shell dumpsys procstats --clear

echo "End"