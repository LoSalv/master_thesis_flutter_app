import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final String path;
  const ImageScreen({Key? key, required String this.path}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  double _scale = 1.0;
  double? _width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        child: Image.asset(
          widget.path,
          // scale: _scale,
          width: _width,
        ),
        onTap: () {
          int r = _scale.round();
          switch (r) {
            case 1:
              {
                setState(() {
                  _scale = 2.0;
                  _width = 350;
                });
              }
              break;
            case 2:
              {
                setState(() {
                  _scale = 3.0;
                  _width = 200;
                });
              }
              break;
            case 3:
              {
                setState(() {
                  _scale = 1.0;
                  _width = null;
                });
              }
              break;
          }
          print(widget.path + " " + _scale.toString());
        },
      ),
    );
  }
}
