import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:contacts_service/contacts_service.dart';

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
      permissionFromString('Permission.ReadContacts'));
  await SimplePermissions.requestPermission(
      permissionFromString('Permission.WriteContacts'));

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _create() async {
    Contact contact = Contact(
        familyName: 'Cairns',
        givenName: 'Bryan',
        emails: [Item(label: 'work', value: 'bcairns@voidrealms.com')]);
    await ContactsService.addContact(contact);
    showInSnackBar('Created contact');
  }


  void _find() async {
    Iterable<Contact> people =
        await ContactsService.getContacts(query: 'Bryan');
    showInSnackBar('There are ${people.length} people named Bryan');
  }

  void _read() async {
    Iterable<Contact> people =
        await ContactsService.getContacts(query: 'Bryan');
    Contact contact = people.first;
    showInSnackBar('Bryan email is ${contact.emails.first.value}');
  }

  void _delete() async {
    Iterable<Contact> people =
        await ContactsService.getContacts(query: 'Bryan');
    Contact contact = people.first;

    await ContactsService.deleteContact(contact);
    showInSnackBar('Bryan deleted');
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              Text('Contacts'),
              RaisedButton(
                onPressed: _create,
                child: Text('Create'),
              ),
              RaisedButton(
                onPressed: _find,
                child: Text('Find'),
              ),
              RaisedButton(
                onPressed: _read,
                child: Text('Read'),
              ),
              RaisedButton(
                onPressed: _delete,
                child: Text('Delete'),
              ),
              RaisedButton(
                onPressed: SimplePermissions.openSettings,
                child: Text('Permissions'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
