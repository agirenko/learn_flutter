import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Home Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Welcome Home'),
//              RaisedButton(
//                onPressed: () {
//                  Navigator.of(context).pushNamed('/Second');
//                },
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Second', (Route<dynamic> route) => false);
                },
                child: new Text('Next'),
              ),
//                child: Text('Next'),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
