import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

//display a map
//https://pub.dartlang.org/packages/flutter_map#-installing-tab-

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  MapController mapController;
  Map<String, LatLng> coordinates;
  List<Marker> markers;

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    coordinates = Map<String, LatLng>();
    coordinates.putIfAbsent("Chicago", () => LatLng(41.8781, -87.6298));
    coordinates.putIfAbsent("Detroit", () => LatLng(42.3314, -83.0458));
    coordinates.putIfAbsent("Lansing", () => LatLng(42.7325, -84.5555));

    markers = List<Marker>();

    for (int i = 0; i < coordinates.length; i++) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: coordinates.values.elementAt(i),
          builder: (ctx) => Icon(
                Icons.pin_drop,
                color: Colors.red,
              ),
        ),
      );
    }
  }

  void _showCoordinate(int index) {
    mapController.move(coordinates.values.elementAt(index), 10.0);
  }

  List<Widget> _makeButtons() {
    List<Widget> list = List<Widget>();

    for (int i = 0; i < coordinates.length; i++) {
      list.add(
        RaisedButton(
          onPressed: () => _showCoordinate(i),
          child: Text(
            coordinates.keys.elementAt(i),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maps Interaction',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: _makeButtons(),
              ),
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: LatLng(41.8781, -87.6298),
                    zoom: 5.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: markers,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
