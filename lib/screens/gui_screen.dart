import 'dart:math';

import 'package:flutter/material.dart';
import 'package:master_thesis_flutter_app/screens/gui_tabs/image_tab.dart';
import 'package:master_thesis_flutter_app/screens/gui_tabs/input_tab.dart';
import 'package:master_thesis_flutter_app/screens/gui_tabs/list_tab.dart';

class GUIScreen extends StatefulWidget {
  static String id = 'cpu_screen';
  const GUIScreen({Key? key}) : super(key: key);

  @override
  State<GUIScreen> createState() => _GUIScreenState();
}

class _GUIScreenState extends State<GUIScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const ListTab(),
    const InputTab(),
    ImageTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("GUI"),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.input),
              label: 'Input Forms',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Image',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[500],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
