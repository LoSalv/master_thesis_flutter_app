echo "### Starting experiment ###"

adb shell dumpsys procstats --clear
adb shell settings put system screen_brightness 1
$startDate = Get-Date

function Take-Screenshot {
        param ($i)
        adb shell screencap -p /sdcard/image.png
        adb pull /sdcard/image.png .\image$i.png
}

For ($i = 0; $i -lt 10; $i++) {
        echo "### Starting run #$i ###"

        adb shell monkey -p lord.app.com 1
        sleep 2
        adb shell input tap 300 345
        sleep 2
                
        #run task
        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell input tap 300 700

        sleep 1500

        adb shell input tap 300 800

        sleep 2

        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell dumpsys battery | Select-String "temperature"

        Take-Screenshot $i

        adb shell am force-stop lord.app.com
        adb shell pm clear lord.app.com

        sleep 300
}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"

adb shell dumpsys procstats --hours 6 lord.app.com
adb shell dumpsys procstats --clear

adb shell settings put system screen_brightness 158


echo "End"