import 'dart:math';

import 'package:flutter/material.dart';
import 'package:master_thesis_flutter_app/screens/gui_tabs/image_tab.dart';
import 'package:master_thesis_flutter_app/screens/gui_tabs/input_tab.dart';
import 'package:master_thesis_flutter_app/screens/gui_tabs/list_tab.dart';

class UIScreen extends StatefulWidget {
  static String id = 'ui_screen';
  const UIScreen({Key? key}) : super(key: key);

  @override
  State<UIScreen> createState() => _UIScreenState();
}

class _UIScreenState extends State<UIScreen> {
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
          title: const Text("UI"),
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
