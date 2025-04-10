import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationExample extends StatefulWidget {
  @override
  _AnimationExampleState createState() => _AnimationExampleState();

}

class _AnimationExampleState extends State<AnimationExample> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  void _animateContainer() {
    setState(() {
      final random = Random();
      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();
      _color = Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1,);
      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animasi'),
      ),
      body: Center(
        child: AnimatedContainer(width: _width,
            height: _height,
            decoration: BoxDecoration(
                color: _color, borderRadius: _borderRadius),
            duration: Duration(seconds: 2),curve: Curves.fastOutSlowIn,),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _animateContainer,
    child: Icon(Icons.play_arrow),
    ),
    );
  }
}