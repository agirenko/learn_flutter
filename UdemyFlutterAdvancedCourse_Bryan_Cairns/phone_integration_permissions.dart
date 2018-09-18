import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ),);
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  String status;
  Permission permission;

  @override
  void initState() {
    super.initState();
    status = 'Select an item';
    print(Permission.values);
  }

  requestPermission() async {
    bool res = await SimplePermissions.requestPermission(permission);
    print('Permissiosn result is ${res.toString()}');

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print('Permissiosn result is ${res.toString()}');

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  getPermissionStatus() async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print('Permissiosn result is ${res.toString()}');

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  onDropDownChanged(Permission permission) {
    setState(() {
      this.permission = permission;
      status = 'Click a button below';
    });
    print(permission);
  }

  List<DropdownMenuItem<Permission>> _getDropDownItems() {
    List<DropdownMenuItem<Permission>> items =
        List<DropdownMenuItem<Permission>>();
    Permission.values.forEach((permission) {
      var item = DropdownMenuItem(
        child: Text(getPermissionString(permission)),
        value: permission,
      );
      items.add(item);
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Integration Permissions'),
      ),
      body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(status),
                DropdownButton(
                    items: _getDropDownItems(),
                    value: permission,
                    onChanged: onDropDownChanged),
                RaisedButton(
                  onPressed: checkPermission,
                  child: Text('Check Permission'),
                ),
                RaisedButton(
                  onPressed: requestPermission,
                  child: Text('Request Permission'),
                ),
                RaisedButton(
                  onPressed: getPermissionStatus,
                  child: Text('Get Status'),
                ),
                RaisedButton(
                  onPressed: SimplePermissions.openSettings,
                  child: Text('Open Settings'),
                ),
              ],
            ),
          )),
    );
  }
}
