import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Map _data;
List _features; // features object list
void main() async {
  _data = await getQuakes();
  _features = _data['features'];

  runApp(
    MaterialApp(
      title: 'Quakes',
      home: Quakes(),
    ),
  );
}

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quakes'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _features.length,
          padding: const EdgeInsets.all(15.0),
          //Date format: https://pub.dartlang.org/packages/intl#-readme-tab-
          //DateFormat: https://www.dartdocs.org/documentation/intl/0.15.1/intl/DateFormat-class.html
          //https://stackoverflow.com/questions/45357520/dart-converting-milliseconds-since-epoch-unix-timestamp-into-human-readable

          itemBuilder: (BuildContext context, int position) {
            //crating the rows for our listview
            if (position.isOdd) return Divider();
            final index = position ~/ 2; // we are dividing position by 2 and returning an integer result

            var format = DateFormat.yMMMMd("en_US").add_jm();
            //var dateString = format.format(date);
            var date = format.format(DateTime.fromMicrosecondsSinceEpoch(_features[index]['properties']['time'] * 1000, isUtc: true));

            return ListTile(
              title: Text(
                " $date",
                //title: Text("Date: $date",
                style: TextStyle(fontSize: 15.5, color: Colors.orange, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                "${_features[index]['properties']['place']}",
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.normal, color: Colors.grey, fontStyle: FontStyle.italic),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  "${_features[index]['properties']['mag']}",
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.normal),
                ),
              ),
              onTap: () {
                _showAlertMessage(context, "${_features[index]['properties']['title']}");
              },
            );
          },
        ),
      ),
    );
  }

  void _showAlertMessage(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text('Quakes'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'))
      ],
    );
    // showDialog(context: context, child: alert);
    showDialog(context: context, builder: (_) => alert);
  }
}

Future<Map> getQuakes() async {
  String apiUrl = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
