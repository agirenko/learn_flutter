import 'package:flutter/material.dart';
import './state_screens/home.dart';
import './state_screens/second.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        //All available pages
        '/Home': (BuildContext context) => Home(),
        '/Second': (BuildContext context) => Second(),
      },
      home: Home(), //first page displayed
    );
  }
}