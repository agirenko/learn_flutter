import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    // controller sets animation duration
    controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    // Tween (abbreviation of "between" sets the start and end value)
    animation = Tween(begin: 0.0, end: 500.0).animate(controller);
    animation.addListener(
      () {
        setState(
          () {
            //The state of the animation has changed
          },
        );
      },
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Tween Animation'),
      ),
      body: Container(
        padding: EdgeInsets.all(0.0),
        height: animation.value, // supplied by animation, non-constant
        width: animation.value, // non-constant, supplied by controller
        child: Center(
          child: FlutterLogo(
            size: 500.0,
          ),
        ),
      ),
    );
  }
}
