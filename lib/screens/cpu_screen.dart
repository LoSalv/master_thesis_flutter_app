import 'dart:math';

import 'package:flutter/material.dart';

class CPUScreen extends StatefulWidget {
  static String id = 'cpu_screen';
  const CPUScreen({Key? key}) : super(key: key);

  @override
  State<CPUScreen> createState() => _CPUScreenState();
}

class _CPUScreenState extends State<CPUScreen> {
  List<String> texts = [];

  void runMultipleTask() {
    setState(() {
      addText("Starting calculations...");
    });

    for (int j = 0; j < 10; j++) {
      DateTime startDate = DateTime.now();
      num result = 0;

      for (var i = pow(15, 7); i >= 0; i--) {
        result += atan(i) * tan(i);
      }

      DateTime endDate = DateTime.now();

      Duration delta = endDate.difference(startDate);
      setState(() {
        addText("Duration: " + delta.toString());
      });
    }
    setState(() {
      addText("End");
    });
  }

  void runTask() {
    setState(() {
      addText("Starting calculations...");
    });

    for (int j = 0; j < 1; j++) {
      DateTime startDate = DateTime.now();
      num result = 0;

      for (var i = pow(20, 7); i >= 0; i--) {
        result += atan(i) * tan(i);
      }

      DateTime endDate = DateTime.now();

      int delta = endDate.difference(startDate).inSeconds;
      setState(() {
        addText("Duration: " + delta.toString());
        addText("Result: " + result.toString());
      });
    }
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
            TextButton(
              onPressed: () {
                runMultipleTask();
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Run Task x 10"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: texts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(texts[index].toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
