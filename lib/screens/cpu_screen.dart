import 'dart:math';

import 'package:flutter/material.dart';

class CPUScreen extends StatefulWidget {
  static String id = 'cpu_screen';
  const CPUScreen({Key? key}) : super(key: key);

  @override
  State<CPUScreen> createState() => _CPUScreenState();
}

class _CPUScreenState extends State<CPUScreen> {
  String text = "Duration:\nResult:";

  void runTask() {
    setState(() {});

    DateTime startDate = DateTime.now();
    num result = 0;

    for (var i = pow(20, 7); i >= 0; i--) {
      result += atan(i) * tan(i);
    }

    DateTime endDate = DateTime.now();

    int delta = endDate.difference(startDate).inSeconds;
    setState(() {
      text = "Duration: " + delta.toString() + "\nResult: " + result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CPU"),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                runTask();
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Run Task"),
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
