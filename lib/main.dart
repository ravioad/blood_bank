import 'package:bloodbank/login_signup/login.dart';
import 'package:bloodbank/login_signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Baloo2',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  bool _clicked = false;
  Color textColor = Colors.grey[600];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 20),
              color: Color(0xFFF3D4DA),
              child: Text("Blood Bank", style: TextStyle(color: Colors.grey[500], fontSize: 45, fontWeight: FontWeight.bold),),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Color(0xFFD1CFDA),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Color(0xFFed97a7),
                            Color(0xFFeab6c0),
                          ]),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            _isLogin ? "Login" : "Sign Up", //Color(0xFF212121)
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: _isLogin ? LoginPage() : SignupPage()));
                      },
                    ),
                    FlatButton(
                      child: Text(
                        _isLogin
                            ? "Don't have account? Signup here:"
                            : "Already have account? Login here:",
                        style: TextStyle(color: textColor, fontSize: 15),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
