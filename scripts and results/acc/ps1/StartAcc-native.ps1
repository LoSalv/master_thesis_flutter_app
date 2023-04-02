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

        adb shell am start -W -n `
                "lord.lorenzosalvemini.callandsmsmanagerapp/lord.lorenzosalvemini.callandsmsmanagerapp.AccelerometerActivity" `
                -a android.intent.action.MAIN `
                -c android.intent.category.LAUNCHER
        sleep 2
                
        #run task
        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell input tap 517 829

        sleep 1500

        adb shell input tap 520 1030

        sleep 2

        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell dumpsys battery | Select-String "temperature"

        Take-Screenshot $i

        adb shell am force-stop lord.lorenzosalvemini.callandsmsmanagerapp
        adb shell pm clear lord.lorenzosalvemini.callandsmsmanagerapp

        sleep 300
}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"

adb shell dumpsys procstats --hours 6 lord.lorenzosalvemini.callandsmsmanagerapp
adb shell dumpsys procstats --clear

adb shell settings put system screen_brightness 158


echo "End"