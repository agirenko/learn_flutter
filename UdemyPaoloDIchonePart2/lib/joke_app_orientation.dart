import 'package:flutter/material.dart';
import './ui/master_detail_screen.dart';

void main() => runApp(new Home());

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Jokes',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MasterDetailScreen(),
    );
  }
}
