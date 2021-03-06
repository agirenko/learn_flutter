import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(curve);

    controller.forward();
  }

  Widget builder(BuildContext context, Widget child) {
    return Container(
      height: animation.value,
      width: animation.value,
      child: FlutterLogo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Builder'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: AnimatedBuilder(
            animation: animation,
            builder: builder,
          ),
        ),
      ),
    );
  }
}
