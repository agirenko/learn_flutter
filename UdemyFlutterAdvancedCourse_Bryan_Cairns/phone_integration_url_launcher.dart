import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  void _showUrl() {
    _launch('http://www.voidrealms.com');
  }

  void _showEmail() {
    _launch('mailto:bcairns@voidrealms.com');
  }

  void _showTelephone() {
    _launch('tel:999-999-9999');
  }

  void _showSms() {
    _launch('sms:999-999-9999');
  }

  void _launch(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch Url';
    }
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _showUrl,
                child: Text('URL'),
              ),
              RaisedButton(
                onPressed: _showEmail,
                child: Text('Email'),
              ),
              RaisedButton(
                onPressed: _showSms,
                child: Text('Sms'),
              ),
              RaisedButton(
                onPressed: _showTelephone,
                child: Text('Telephone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
