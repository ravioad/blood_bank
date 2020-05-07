import 'package:bloodbank/login_signup/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = new GlobalKey<FormState>();
  Color background = Color(0xFFD1CFDA);
  Color accentColor = Color(0xFFef889b);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'heroSignup',
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: background,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Already have account? Login",
                style: TextStyle(color: accentColor, fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()),
                );
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage('assets/images/signupbackground.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
