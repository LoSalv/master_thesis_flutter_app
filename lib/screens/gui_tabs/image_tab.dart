import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:master_thesis_flutter_app/screens/image_screen.dart';

class ImageTab extends StatelessWidget {
  final List _images = [
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image.jpg',
    'assets/images/image1.png',
    'assets/images/image2.png',
  ];
  ImageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Image.asset('assets/images/image.jpg');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Image.asset(_images[index]),
          onTap: () {
            (Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageScreen(path: _images[index]),
              ),
            ));
          },
        );
      },
    );
  }
}
