import 'dart:math';

import 'package:flutter/material.dart';

class AnimationPlayground extends StatefulWidget {
  @override
  _AnimationPlaygroundState createState() => _AnimationPlaygroundState();
}

class _AnimationPlaygroundState extends State<AnimationPlayground>
    with SingleTickerProviderStateMixin {
  double _opacity = 1.0;
  double _padding = 20.0;
  double _top = 50.0;
  double _left = 50.0;
  double _scale = 1.0;
  double _rotation = 0.0;
  Color _color = Colors.blueAccent;

  late AnimationController _borderController;
  late Animation<double> _borderWidthAnimation;

  @override
  void initState() {
    super.initState();
    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _borderWidthAnimation = Tween<double>(begin: 5.0,end: 20.0).animate(CurvedAnimation(parent: _borderController, curve: Curves.easeInOut),
    );
    _borderController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  void _triggerOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.5 : 1.0;
    });
  }

  void _triggerPadding() {
    setState(() {
      _padding = _padding == 20.0 ? 50.0 : 20.0;
    });
  }

  void _triggerPosition() {
    setState(() {
      final random = Random();
      _top = random.nextInt(200).toDouble() + 50;
      _left = random.nextInt(200).toDouble() + 50;
    });
  }

  void _triggerScale() {
    setState(() {
      _scale = _scale == 1.0 ? 1.5 : 1.0;
    });
  }

  void _triggerRotation() {
    setState(() {
      _rotation += pi / 4;
    });
  }

  void _triggerColorChange() {
    setState(() {
      final random = Random();
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Playground')),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: _top,
            left: _left,
            child: AnimatedScale(
              scale: _scale,
              duration: Duration(milliseconds: 500),
              child: AnimatedRotation(
                turns: _rotation,
                duration: Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 500),
                  child: AnimatedPadding(
                    padding: EdgeInsets.all(_padding),
                    duration: Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _color,
                        border: Border.all(
                          color: Colors.black,
                          width: _borderWidthAnimation.value,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _triggerOpacity,
                    child: Text('Opacity'),
                  ),
                  ElevatedButton(
                    onPressed: _triggerPadding,
                    child: Text('Padding'),
                  ),
                  ElevatedButton(
                    onPressed: _triggerPosition,
                    child: Text('Position'),
                  ),
                  ElevatedButton(
                    onPressed: _triggerScale,
                    child: Text('Scale'),
                  ),
                  ElevatedButton(
                    onPressed: _triggerRotation,
                    child: Text('Rotation'),
                  ),
                  ElevatedButton(
                    onPressed: _triggerColorChange,
                    child: Text('Color'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
