import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class MyButton extends AnimatedWidget {
  bool large = false;

  static final _sizeTween = Tween<double>(
    begin: 1.0,
    end: 2.0,
  );
  AnimationController controller;

  MyButton(
      {Key key, Animation<double> animation, AnimationController controller})
      : super(key: key, listenable: animation) {
    this.controller = controller;
  }

  void onPressed() {
    if (!large) {
      controller.forward();
      large = true;
    } else {
      controller.reverse();
      large = false;
    }
  }

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.scale(
      scale: _sizeTween.evaluate(animation),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text('Click me'),
      ),
    );
  }
}

class _State extends State<MyApp> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Assignment'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Widgets here'),
              MyButton(
                animation: animation,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
