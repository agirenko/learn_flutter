import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  String _status;

  @override
  void initState() {
    _status = 'Not Authenticated';
  }

  void _signInAnon() async {
    FirebaseUser user = await _auth.signInAnonymously();
    if (user != null && user.isAnonymous == true) {
      setState(() {
        _status = 'Signed in Anonymously';
      });
    } else {
      setState(() {
        _status = 'Sign in failed!';
      });
    }
  }

  void _signInGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    if (user != null && user.isAnonymous == false) {
      setState(() {
        _status = 'Signed in with Google';
      });
    } else {
      setState(() {
        _status = 'Google Signin Failed';
      });
    }
  }

  void _signOut() async {
    await _auth.signOut();
    setState(() {
      _status = 'Signed out';
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
              RaisedButton(
                onPressed: _signOut,
                child: Text('Sign out'),
              ),
              RaisedButton(
                onPressed: _signInAnon,
                child: Text('Sign in Anon'),
              ),
              RaisedButton(
                onPressed: _signInGoogle,
                child: Text('Sign in Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
