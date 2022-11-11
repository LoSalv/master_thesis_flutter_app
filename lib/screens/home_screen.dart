import 'package:flutter/material.dart';
import 'package:master_thesis_flutter_app/screens/cpu_screen.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Master Thesis App"),
            ),
            body: Column(
              children: [
                Card(
                  child: GestureDetector(
                    child: const Text("CPU"),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CPUScreen.id,
                      );
                    },
                  ),
                )
              ],
            )));
  }
}
