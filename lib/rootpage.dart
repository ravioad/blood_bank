import 'package:bloodbank/main.dart';
import 'package:bloodbank/screens/home.dart';
import 'package:bloodbank/services/authentication.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String userId = "";
  @override
  void initState() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
    super.initState();
  }

  void loginCallback() {
    print('Callback initiated');
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build call');
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return MyHomePage(
          loginCallback: loginCallback,
          auth: widget.auth,
        );
        break;
      case AuthStatus.LOGGED_IN:
        return Home(
          auth: widget.auth,
          logoutCallback: logoutCallback,
          userId: userId,
        );
        break;
      default:
        return buildWaitingScreen();
        break;
    }
  }
}
