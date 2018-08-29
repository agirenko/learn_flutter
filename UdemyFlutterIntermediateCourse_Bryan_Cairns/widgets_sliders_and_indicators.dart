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

class _State extends State<MyApp> {
  double _value = 0.0;

  void _onChanged(double value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name here'),
      ),

      body: Container(
        padding: EdgeInsets.all(62.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Slider(
                value: _value,
                onChanged: _onChanged,
                divisions: 10,
                label: 'Power',
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: LinearProgressIndicator(
                  value: _value,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: CircularProgressIndicator(
                  value: _value,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
