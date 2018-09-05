import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String outputText;
  MyWidget(this.outputText);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Text(outputText==''?'Hello World':outputText),
    );
  }
}
