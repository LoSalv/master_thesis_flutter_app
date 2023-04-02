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
                "com.example.master_thesis_flutter_app/com.example.master_thesis_flutter_app.MainActivity" `
                -a android.intent.action.MAIN `
                -c android.intent.category.LAUNCHER
        sleep 2
                
        #run task
        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell input tap 460 670
        sleep 2

        adb shell input tap 530 460
        sleep 1500

        adb shell input tap 530 560
        sleep 2

        adb shell dumpsys battery | Select-String "Charge Counter"
        adb shell dumpsys battery | Select-String "temperature"

        Take-Screenshot $i

        adb shell am force-stop com.example.master_thesis_flutter_app
        adb shell pm clear com.example.master_thesis_flutter_app

        sleep 300
}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"

adb shell dumpsys procstats --hours 6 com.example.master_thesis_flutter_app
adb shell dumpsys procstats --clear

adb shell settings put system screen_brightness 158

echo "End"