import 'package:flutter/material.dart';
import 'dart:io';
import './firebase_storage/auth.dart' as fbAuth;
import './firebase_storage/storage.dart' as fbStorage;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart'; //needed for basename

void main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'firebaseapp',
      options: new FirebaseOptions(
        googleAppID: '1:387510158898:android:c01a519c8fdd00d9',
        gcmSenderID: '387510158898',
        apiKey: 'AIzaSyBpTx6sBfywoe7n4gxFaT-Yzt4zS5-EMzw',
        projectID: 'fir-app-23eb6',
      ));

  final FirebaseStorage storage = new FirebaseStorage(app: app, storageBucket: 'gs://fir-app-23eb6.appspot.com');

  runApp(new MaterialApp(
    home: new MyApp(storage: storage),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({this.storage});

  final FirebaseStorage storage;

  @override
  _State createState() => new _State(storage: storage);
}

class _State extends State<MyApp> {
  _State({this.storage});

  final FirebaseStorage storage;

  String _status;
  String _location;

  @override
  void initState() {
    _status = 'Not Authenticated';
    _signIn();
  }

  void _signIn() async {
    if (await fbAuth.signInGoogle() == true) {
      setState(() {
        _status = 'Signed In';
      });
    } else {
      setState(() {
        _status = 'Could not sign in!';
      });
    }
  }

  void _signOut() async {
    if (await fbAuth.signOut() == true) {
      setState(() {
        _status = 'Signed out';
      });
    } else {
      setState(() {
        _status = 'Signed in';
      });
    }
  }

  void _upload() async {
    Directory systemTempDir = Directory.systemTemp;
    File file = await File('${systemTempDir.path}/foo.txt').create();
    await file.writeAsString('hello world');

    String location = await fbStorage.upload(file, basename(file.path));
    setState(() {
      _location = location;
      _status = 'Uploaded!';
    });

    print('Uploaded to ${_location}');
  }

  void _download() async {
    if (_location.isEmpty) {
      setState(() {
        _status = 'Please upload first!';
      });
      return;
    }

    Uri location = Uri.parse(_location);
    String data = await fbStorage.download(location);
    setState(() {
      _status = 'Downloaded: ${data}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(_status),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: _signOut,
                    child: new Text('Sign out'),
                  ),
                  new RaisedButton(
                    onPressed: _signIn,
                    child: new Text('Sign in Google'),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: _upload,
                    child: new Text('Upload'),
                  ),
                  new RaisedButton(
                    onPressed: _download,
                    child: new Text('Download'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
