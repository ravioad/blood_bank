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
  Color textColor = Colors.grey[600];
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;
  @override
  void initState() {
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _scaleAnimation = Tween<double>(begin: 1, end: 30).animate(_scaleController)
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
         Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: _isLogin?LoginPage():SignupPage())); 
          _scaleController.reverse();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color: Color(0xFFF3D4DA),
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
                  Text(
                    _isLogin ? "Login" : "Sign Up", //Color(0xFF212121)
                    style: TextStyle(
                        color: textColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: EdgeInsets.all(35),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFeab6c0),
                              image: DecorationImage(
                                image: AssetImage(_isLogin
                                    ? 'assets/images/logout32.png'
                                    : 'assets/images/login32.png'),
                              )),
                        ),
                      ),
                    ),
                    onTap: () {
                      _scaleController.forward();
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
    ));
  }
}
