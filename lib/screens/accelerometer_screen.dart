import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatefulWidget {
  static String id = 'accelerometer_screen';
  const AccelerometerScreen({Key? key}) : super(key: key);

  @override
  State<AccelerometerScreen> createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  List<double>? _accelerometerValues;
  List<int> times = [];
  double? average;
  int? min;
  int? max;
  Stopwatch stopwatch = Stopwatch();
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accelerometer measures: $accelerometer'),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              startAccelerometer();
            },
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text("Start Task"),
          ),
          TextButton(
            onPressed: () {
              stopTask();
            },
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text("Stop Task"),
          ),
          Text('Average time between measurements: $average'),
          // Text('Min: $min'),
          // Text('Max: $max'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    stopwatch.stop();
  }

  void startAccelerometer() {
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          times.add(stopwatch.elapsed.inMilliseconds);
          stopwatch.reset();
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    stopwatch.start();
  }

  void stopTask() {
    stopwatch.stop();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    min = 500000;
    max = 0;
    average = 0;

    for (int i in times) {
      if (i < min!.toInt()) min = i;
      if (i > max!.toInt()) max = i;

      average = average! + i.toDouble();
    }

    average = average! / times.length;

    setState(() {});
  }
}
