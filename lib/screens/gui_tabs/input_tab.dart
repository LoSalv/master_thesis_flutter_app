import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InputTab extends StatefulWidget {
  const InputTab({Key? key}) : super(key: key);

  @override
  State<InputTab> createState() => _InputTabState();
}

class _InputTabState extends State<InputTab> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: TextField(
            controller: _firstController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: TextField(
            controller: _secondController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: TextField(
            controller: _thirdController,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextButton(
          onPressed: () {
            _firstController.clear();
            _secondController.clear();
            _thirdController.clear();
          },
          child: Card(
            color: Colors.blue[100],
            child: const Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: Text("Clear"),
            ),
          ),
        ),
      ],
    );
  }
}
