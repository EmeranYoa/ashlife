import 'package:flutter/material.dart';

class AshlifeImage extends StatelessWidget {
  final double height;
  final double width;
  final String path;
  const AshlifeImage({Key? key, required this.height, required this.width, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
