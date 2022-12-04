import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListTab extends StatelessWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = [
      'Hello',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
      'World',
    ];
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data[index],
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}
