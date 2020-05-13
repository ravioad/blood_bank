import 'package:bloodbank/services/authentication.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final userId;

  const Home({Key key, this.auth, this.logoutCallback, this.userId})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
            ),
            onPressed: () {
              widget.logoutCallback();
              widget.auth.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text("welcome to home!"),
      ),
    );
  }
}
