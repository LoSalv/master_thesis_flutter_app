echo "### Starting experiment ###"

function Scroll-Down {
    For ($i = 0; $i -lt 3; $i++) {
        adb shell input swipe 580 2030 670 360
        sleep 1
    }
    return
}

function Scroll-Up {
    For ($i = 0; $i -lt 3; $i++) {
        adb shell input swipe 670 460 580 2030
        sleep 1
    }
    return
}

function Go-Back {
    adb shell input swipe 0 1300 330 1300
    sleep 1
}

function Tap-Image {
    adb shell input tap 500 1300
    sleep 1
}

function Run-Task {
    For ($i = 0; $i -lt 6; $i++) {
        #open list tab
        adb shell input tap 92 375
        sleep 1
        
        #scroll the list
        Scroll-Down
        Scroll-Up
                
        #open input tab
        adb shell input tap 460 350
        sleep 1

        #compile the inputs
        adb shell input tap 266 640
        sleep 1
        adb shell input text "First"
        sleep 1
        adb shell input tap 266 830
        sleep 1
        adb shell input text "Second"
        sleep 1
        adb shell input tap 266 1035
        sleep 1
        adb shell input text "Third"
        sleep 1

        #hide keyboard
        adb shell input keyevent 111

        #clear inputs
        adb shell input tap 523 1295
        sleep 1

        #open image tab
        adb shell input tap 892 388
        sleep 1
        Scroll-Down
        Scroll-Up

        #open image screens
        adb shell input tap 110 450
        sleep 1
        Tap-Image
        Tap-Image
        Tap-Image
        Go-Back

        adb shell input tap 530 450
        sleep 1
        Tap-Image
        Tap-Image
        Tap-Image
        Go-Back

        adb shell input tap 800 450
        sleep 1
        Tap-Image
        Tap-Image
        Tap-Image
        Go-Back

    }
}

adb shell settings put system screen_brightness 158
adb shell dumpsys procstats --clear
$startDate = Get-Date

For ($i = 0; $i -lt 19; $i++) {
    echo "### Starting run #$i ###"

    adb shell am start -W -n `
        "lord.lorenzosalvemini.callandsmsmanagerapp/lord.lorenzosalvemini.callandsmsmanagerapp.MainActivity" `
        -a android.intent.action.MAIN `
        -c android.intent.category.LAUNCHER
    sleep 2

    #open GUI screen
    adb shell input tap 495 1230
    sleep 1

    adb shell dumpsys battery | Select-String "Charge Counter"

    Run-Task

    adb shell dumpsys battery | Select-String "Charge Counter"
    adb shell dumpsys battery | Select-String "temperature"

    adb shell am force-stop lord.lorenzosalvemini.callandsmsmanagerapp
    adb shell pm clear lord.lorenzosalvemini.callandsmsmanagerapp

    sleep 60
}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"

adb shell dumpsys procstats --hours 6 lord.lorenzosalvemini.callandsmsmanagerapp
adb shell dumpsys procstats --clear

echo "End"