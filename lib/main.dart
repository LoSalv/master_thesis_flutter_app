import 'package:flutter/material.dart';
import 'package:master_thesis_flutter_app/screens/home_screen.dart';
import 'package:master_thesis_flutter_app/screens/cpu_screen.dart';
import 'package:master_thesis_flutter_app/screens/accelerometer_screen.dart';

import 'screens/ui_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'master thesis app',
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          CPUScreen.id: (context) => CPUScreen(),
          UIScreen.id: (context) => UIScreen(),
          AccelerometerScreen.id: (context) => AccelerometerScreen(),
        });
  }
}
