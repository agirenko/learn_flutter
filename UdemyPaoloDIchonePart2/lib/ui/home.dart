import 'package:flutter/material.dart';
import './notodo_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("No To Do"),
         backgroundColor: Colors.black54,
       ),
      body: NoToDoScreen(),
    );
  }
}
