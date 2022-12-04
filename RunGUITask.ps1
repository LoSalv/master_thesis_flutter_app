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

function Run-Task {
    For ($i = 0; $i -lt 3; $i++) {
        #open list tab
        adb shell input tap 136 2260
        sleep 1
        
        #scroll the list
        Scroll-Down
        Scroll-Up
                
        #open input tab
        adb shell input tap 560 2260
        sleep 1

        #compile the inputs
        adb shell input tap 747 363
        sleep 1
        adb shell input text "First"
        sleep 1
        adb shell input tap 747 524
        sleep 1
        adb shell input text "Second"
        sleep 1
        adb shell input tap 747 670
        sleep 1
        adb shell input text "Third"
        sleep 1

        #hide keyboard
        adb shell input keyevent 111

        #clear inputs
        adb shell input tap 498 914
        sleep 1

        #open image tab
        adb shell input tap 890 2330
        sleep 1
        Scroll-Down
        Scroll-Up

        #open image screens
        adb shell input tap 110 450
        sleep 1
        Go-Back

        adb shell input tap 530 450
        sleep 1
        Go-Back

        adb shell input tap 800 450
        sleep 1
        Go-Back

    }
}

For ($i = 0; $i -lt 10; $i++) {
    echo "### Starting run #$i ###"

    adb shell am start -W -n `
        "com.example.master_thesis_flutter_app/com.example.master_thesis_flutter_app.MainActivity" `
        -a android.intent.action.MAIN `
        -c android.intent.category.LAUNCHER
    sleep 2

    #open GUI screen
    adb shell input tap 495 554
    sleep 1

    adb shell dumpsys battery | Select-String "Charge Counter"

    Run-Task

    adb shell dumpsys battery | Select-String "Charge Counter"
    adb shell dumpsys battery | Select-String "temperature"

    adb shell am force-stop com.example.master_thesis_flutter_app
    adb shell pm clear com.example.master_thesis_flutter_app

    sleep 60
}