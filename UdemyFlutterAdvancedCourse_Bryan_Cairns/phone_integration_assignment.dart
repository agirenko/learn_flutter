import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

Permission permissionFromString(String value) {
  Permission permission;
  for (Permission item in Permission.values) {
    if (item.toString() == value) {
      permission = item;
      break;
    }
  }
  return permission;
}

void main() async {
  await SimplePermissions.requestPermission(
    permissionFromString('Permission.WriteExternalStorage'),
  );
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  Permission permission;
  String status;

  @override
  void initState() {
    permission = permissionFromString('Permission.WriteExternalStorage');

    checkPermission();
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Integration Assignment'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[Text(status)],
          ),
        ),
      ),
    );
  }
}
