import 'dart:math' as math;

import 'package:flutter/material.dart';


class HomeFab extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return _HomeFab();
    }
}

class _HomeFab extends State<HomeFab> with TickerProviderStateMixin{
AnimationController _controller;


@override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
      return FloatingActionButton(
        onPressed: () {
          if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
        },
        tooltip: 'Add List',
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child){
            return Transform(
              transform:
                  Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
              alignment: FractionalOffset.center,
              child: Icon(_controller.isDismissed
                  ? Icons.add
                  : Icons.close),
            );
          },
        ),
      );
    }
}