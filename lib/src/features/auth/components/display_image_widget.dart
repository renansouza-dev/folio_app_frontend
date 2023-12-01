import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      child: CircleAvatar(
        backgroundImage: NetworkImage(imagePath),
        radius: 70,
      ),
    );
  }
}
