import './models/user.dart';
import './utils/database_helper.dart';
import 'package:flutter/material.dart';

List _users;

void main() async {
  var db = DatabaseHelper();

  //Add user
  await db.saveUser(User("Genyy", "musician"));

  int count = await db.getCount();
  print("Count: $count");

  //Retrieving a user
  User ana = await db.getUser(1);
  User anaUpdated = User.fromMap({"username": "UpdatedAna", "password": "updatedPassword", "id": 1});

  //Update
  await db.updateUser(anaUpdated);

  //Delete a User
  // int userDeleted = await db.deleteUser(2);

  // print("Delete User:  $userDeleted");

  //Get all users;
  _users = await db.getAllUsers();
  for (int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);

    print("Username: ${user.username}, User Id: ${user.id}");
  }

  runApp(MaterialApp(
    title: "Database",
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (_, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${User.fromMap(_users[position]).username.substring(0, 1)}"),
              ),
              title: Text("User: ${User.fromMap(_users[position]).username}"),
              subtitle: Text("Id: ${User.fromMap(_users[position]).id}"),
              onTap: () => debugPrint("${User.fromMap(_users[position]).password}"),
            ),
          );
        },
      ),
    );
  }
}
