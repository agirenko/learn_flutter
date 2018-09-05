import 'package:flutter/material.dart';
import 'authenticator.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  bool _isAuthenticated;

  void _onAuthenticated(bool value) {
    setState(() => _isAuthenticated = value);
  }

  @override
  void initState() {
    super.initState();
    _isAuthenticated = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Child To Parent'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Authenticator(
                onAuthenticated: _onAuthenticated,
              ),
              Text('Authenticated: $_isAuthenticated')
            ],
          ),
        ),
      ),
    );
  }
}
