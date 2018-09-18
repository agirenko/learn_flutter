import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import './firebase_storage/auth.dart' as fbAuth;
import './firebase_storage/storage.dart' as fbStorage;
import './firebase_storage/database.dart' as fbDatabase;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart'; //needed for basename

void main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'firebaseapp',
      options: FirebaseOptions(
        googleAppID: '1:352942801806:android:383114c5c27090c2',
        gcmSenderID: '352942801806',
        apiKey: 'AIzaSyB10pg0ziWMaRqvApS7ij48zoU9wC6ugAU',
        projectID: 'fir-app-c70aa',
        databaseURL: 'https://fir-app-c70aa.firebaseio.com',
      ));

  final FirebaseStorage storage = FirebaseStorage(app: app, storageBucket: 'gs://fir-app-c70aa.appspot.com');
  final FirebaseDatabase database = FirebaseDatabase(app: app);

  runApp(MaterialApp(
    home: MyApp(app: app, database: database, storage: storage),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({this.app, this.database, this.storage});

  final FirebaseApp app;
  final FirebaseDatabase database;
  final FirebaseStorage storage;

  @override
  _State createState() => _State(app: app, database: database, storage: storage);
}

class _State extends State<MyApp> {
  _State({this.app, this.database, this.storage});

  final FirebaseApp app;
  final FirebaseDatabase database;
  final FirebaseStorage storage;

  String _status;
  String _location;
  StreamSubscription<Event> _counterSubscription;

  String _username;

  @override
  void initState() {
    super.initState();
    _status = 'Not Authenticated';
    _signIn();
  }

  void _signIn() async {
    if (await fbAuth.signInGoogle() == true) {
      _username = await fbAuth.username();
      setState(() {
        _status = 'Signed In';
      });
      _initDatabase();
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

  void _initDatabase() async {
    await fbDatabase.init(database);

    _counterSubscription = fbDatabase.counterRef.onValue.listen((Event event) {
      setState(() {
        fbDatabase.error = null;
        fbDatabase.counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        fbDatabase.error = error;
      });
    });
  }

  void _increment() async {
    int value = fbDatabase.counter + 1;
    fbDatabase.setCounter(value);
  }

  void _decrement() async {
    int value = fbDatabase.counter - 1;
    fbDatabase.setCounter(value);
  }

  void _addData() async {
    await fbDatabase.addData(_username);
    setState(() {
      _status = 'Data Added';
    });
  }

  void _removeData() async {
    await fbDatabase.removeData(_username);
    setState(() {
      _status = 'Data Removed';
    });
  }

  void _setData(String key, String value) async {
    await fbDatabase.setData(_username, key, value);
    setState(() {
      _status = 'Data Set';
    });
  }

  void _updateData(String key, String value) async {
    await fbDatabase.updateData(_username, key, value);
    setState(() {
      _status = 'Data Updated';
    });
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
              Text(_status),
              Text('Counter ${fbDatabase.counter}'),
              Text('Error: ${fbDatabase.error.toString()}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _signOut,
                    child: Text('Sign out'),
                  ),
                  RaisedButton(
                    onPressed: _signIn,
                    child: Text('Sign in Google'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _addData,
                    child: Text('Add Data'),
                  ),
                  RaisedButton(
                    onPressed: _removeData,
                    child: Text('Remove Data'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _setData('Key2', 'This is a set value'),
                    child: Text('Set Data'),
                  ),
                  RaisedButton(
                    onPressed: () => _updateData('Key2', 'This is a updated value'),
                    child: Text('Update Data'),
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
