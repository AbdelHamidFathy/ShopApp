import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  String image;
  FullScreenImage(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              image,
            ),
          ),
        ),
        /* onTap: () {
          Navigator.pop(context);
        }, */
        onTapUp: (t) {
          Navigator.pop(context);
        }, 
        onTapDown: (t) {
          Navigator.pop(context);
        },
      ),
    );
  }
}