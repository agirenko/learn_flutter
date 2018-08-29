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
  int counter = 0;
  List<Widget> _list = List<Widget>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 7; i++) {
      Widget child = _newItem(i);
      _list.add(child);
    }
  }

  void _onButtonClicked() {
    Widget child = _newItem(counter);
    setState(() => _list.add(child));
  }

  Widget _newItem(int i) {
    Key key = Key('item_$i');
    Container child = Container(
      key: key,
      padding: EdgeInsets.all(3.0),
      child: Chip(
        label: Text('$i Name here'),
        deleteIconColor: Colors.red,
        deleteButtonTooltipMessage: 'Delete',
        onDeleted: () => _removeItem(key),
        avatar: CircleAvatar(
          backgroundColor: Colors.green.shade800,
          child: Text(
            i.toString(),
          ),
        ),
      ),
    );
    counter++;
    return child;
  }

  void _removeItem(Key key) {
    for (int i = 0; i < _list.length; i++) {
      Widget child = _list.elementAt(i);
      if (child.key == key) {
        setState(() => _list.removeAt(i));
        print('Removing ${key.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onButtonClicked,
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: _list,
          ),
        ),
      ),
    );
  }
}
