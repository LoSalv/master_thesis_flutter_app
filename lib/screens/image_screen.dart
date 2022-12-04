import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String path;
  const ImageScreen({Key? key, required String this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Image.asset(path),
    );
  }
}
