import 'package:flutter/material.dart';
import 'nameeditor.dart';

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

  String _name;

  @override
  void initState() {
    super.initState();
    _name = '';
  }

  void onNameChanged(String value) {
    setState(() => _name = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name here'),
      ),
      body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Hello $_name'),
                NameEditor(onNameChanged),
              ],
            ),
          ),
      ),
    );
  }
}