import 'package:flutter/material.dart';
import 'package:master_thesis_flutter_app/screens/cpu_screen.dart';
import 'package:master_thesis_flutter_app/screens/gui_screen.dart';

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
                const SizedBox(
                  height: 24,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      CPUScreen.id,
                    );
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Center(child: Text("CPU")),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      GUIScreen.id,
                    );
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Center(child: Text("GUI")),
                ),
              ],
            )));
  }
}
