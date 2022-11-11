import 'dart:math';

import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';

class CPUScreen extends StatefulWidget {
  static String id = 'cpu_screen';
  const CPUScreen({Key? key}) : super(key: key);

  @override
  State<CPUScreen> createState() => _CPUScreenState();
}

class _CPUScreenState extends State<CPUScreen> {
  List<String> texts = ["Ciao"];
  @override
  void initState() {
    super.initState();
    runTask();
  }

  void runTask() async {
    setState(() {
      addText("Starting calculations...");
    });
    DateTime startDate = DateTime.now();
    // var battery = Battery();
    // int startBatteryLevel = await battery.batteryLevel;

    num result = 0;

    for (var i = pow(11, 7); i >= 0; i--) {
      result += atan(i) * tan(i);
    }

    // int endBatteryLevel = await battery.batteryLevel;

    DateTime endDate = DateTime.now();
    print(
        "Battery Health: ${(await BatteryInfoPlugin().androidBatteryInfo)?.health}");
    print(
        "Current Now: ${(await BatteryInfoPlugin().androidBatteryInfo)?.currentNow}");
    print(
        "Battery Capacity: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryCapacity}");
    print(
        "Battery Level: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");
    print(
        "Remaining Energy: ${(await BatteryInfoPlugin().androidBatteryInfo)?.remainingEnergy}");
    print("Scale: ${(await BatteryInfoPlugin().androidBatteryInfo)?.scale}");
    print(
        "Voltage: ${(await BatteryInfoPlugin().androidBatteryInfo)?.voltage}");

    Duration delta = endDate.difference(startDate);
    setState(() {
      // addText("Battery level at start: " + startBatteryLevel.toString());
      // addText("Battery level at end: " + endBatteryLevel.toString());
      // addText(
      //     "Battery Delta: " + (endBatteryLevel - startBatteryLevel).toString());
      addText("Duration: " + delta.toString());
    });
    return;
  }

  void addText(String string) {
    print(string);
    texts.add(string);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CPU"),
        ),
        body: ListView.builder(
          itemCount: texts.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(texts[index].toString());
          },
        ),
      ),
    );
  }
}
