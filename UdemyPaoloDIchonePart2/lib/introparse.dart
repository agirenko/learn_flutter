import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("My Application"),
    content: Text(message),
    actions: <Widget>[
      RaisedButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
  // showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<List<dynamic>> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body); // returns a List type
}

void main() async {
  List _data = await getJson();

  print(_data[1]['title']); //just a string

  for (int i = 0; i < _data.length; i++) {
    print("Title ${_data[i]['title']}");
    print("Body: ${_data[i]['body']}");
  }

  var ma = MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('JSON Parse'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(10.5),
          itemBuilder: (BuildContext context, int position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.5),
                ListTile(
                  title: Text(
                    "${_data[position]['title']}",
                    style: TextStyle(fontSize: 17.9),
                  ),
                  subtitle: Text(
                    "${_data[position]['body']}",
                    style: TextStyle(
                      fontSize: 13.9,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text(
                      "${_data[position]['body'][0]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.4,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                  onTap: () => _showOnTapMessage(
                        context,
                        _data[position]['body'],
                      ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );

  runApp(ma);
}

//showDialog(context: context, builder: (context) {
//return alert;
////     return AlertDialog(
////      title: Text('App'),
////      content: Text(message),
////      actions: <Widget>[
////        FlatButton(
////            onPressed: () {
////              Navigator.pop(context);
////            },
////            child: Text('OK'))
////      ],
////    );
//});

/*
   void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text('App'),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'))
    ],
  );
  //showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);



}
 */

/*
  var format = DateFormat("yMd");

                var date = format.format(DateTime.fromMicrosecondsSinceEpoch(_features[index]['properties']['updated']*1000, isUtc: false));
 */
