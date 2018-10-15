import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'SharedPrefs',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  String _savedData = "";

  @override
  void initState() {
    super.initState();

    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data') != null && preferences.getString('data').isNotEmpty) {
        _savedData = preferences.getString("data");
      } else {
        _savedData = "Empty SP";
      }
    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message); // key : value ==> "paulo" : "Smart"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Prefs'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(labelText: 'Write Something'),
          ),
          subtitle: FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              _saveMessage(_enterDataField.text);
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5)),
                Text(_savedData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
