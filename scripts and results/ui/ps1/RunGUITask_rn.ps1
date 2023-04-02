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
        adb shell input swipe 670 360 580 2030
        sleep 1
    }
    return
}

function Go-Back {
    adb shell input tap 71 216
    sleep 1
}

function Tap-Image {
    adb shell input tap 200 500
    sleep 1
}

function Run-Task {
    For ($i = 0; $i -lt 6; $i++) {
        #open list tab
        adb shell input tap 138 2279
        sleep 1
        
        #scroll the list
        Scroll-Down
        Scroll-Up
                
        #open input tab
        adb shell input tap 560 2260
        sleep 1

        #compile the inputs
        adb shell input tap 239 367
        sleep 1
        adb shell input text "First"
        sleep 1
        adb shell input tap 210 515
        sleep 1
        adb shell input text "Second"
        sleep 1
        adb shell input tap 210 664
        sleep 1
        adb shell input text "Third"
        sleep 1

        #hide keyboard
        adb shell input keyevent 111

        #clear inputs
        adb shell input tap 142 818
        sleep 1

        #open image tab
        adb shell input tap 890 2330
        sleep 2
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

    adb shell monkey -p com.rnartifact 1
    sleep 2

    #open GUI screen
    adb shell input tap 154 817
    sleep 1

    adb shell dumpsys battery | Select-String "Charge Counter"

    Run-Task

    adb shell dumpsys battery | Select-String "Charge Counter"
    adb shell dumpsys battery | Select-String "temperature"

    adb shell am force-stop com.rnartifact
    adb shell pm clear com.rnartifact

    sleep 60
}

$endDate = Get-Date

echo "Start date: $startDate"
echo "End date: $endDate"



adb shell dumpsys procstats --hours 5 com.rnartifact
adb shell dumpsys procstats --clear


echo "End" 
