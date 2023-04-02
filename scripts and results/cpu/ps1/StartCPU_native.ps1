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
        adb shell am start -W -n `
                "lord.lorenzosalvemini.callandsmsmanagerapp/lord.lorenzosalvemini.callandsmsmanagerapp.CPUActivity" `
                -a android.intent.action.MAIN `
                -c android.intent.category.LAUNCHER
        adb shell dumpsys battery | Select-String "Charge Counter"
            
        #run task
        adb shell input tap 667 467

        sleep 220
        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell dumpsys battery | Select-String "temperature"

        Take-Screenshot $i
        adb shell am force-stop lord.lorenzosalvemini.callandsmsmanagerapp
        adb shell pm clear lord.lorenzosalvemini.callandsmsmanagerapp

        sleep 600
}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"

adb shell dumpsys procstats --hours 6 lord.lorenzosalvemini.callandsmsmanagerapp
adb shell dumpsys procstats --clear

echo "End"