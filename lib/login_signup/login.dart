import 'package:bloodbank/login_signup/signup.dart';
import 'package:bloodbank/rootpage.dart';
import 'package:bloodbank/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:bloodbank/widgets/widgets.dart';

Widgets widgets = Widgets();

class LoginPage extends StatefulWidget {
  final VoidCallback loginCallback;
  final BaseAuth auth;

  const LoginPage({Key key, this.loginCallback, this.auth}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = new GlobalKey<FormState>();
  Color background = Color(0xFFF3D4DA);
  Color accentColor = Color(0xFF584d9b);
  String _email, _password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";
  bool _rememberMe = false;
  double cardHeight = 300;
  String userId = "";
  @override
  void initState() {
    userId = "";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "heroLogin",
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: background,
          body: Form(
            key: _formKey,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 250,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/signupbackground.png'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 60),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 180,
                      ),
                      formCard(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Checkbox(
                              activeColor: accentColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value;
                                  Fluttertoast.showToast(
                                      msg: value.toString(),
                                      toastLength: Toast.LENGTH_SHORT);
                                });
                              },
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(color: accentColor, fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          widgets.loginButton(onPressed: validateAndSubmit)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      showErrorMessage(),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        cardHeight = 300;
      });
      return true;
    } else {
      setState(() {
        cardHeight = 350;
      });
      return false;
    }
  }

  void validateAndSubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _errorMessage = "";
        _isLoading = true;
      });
    }
    if (validateAndSave()) {
      print("clicked");
      String Id = "";
      try {
        Id = await widget.auth.signIn(email: _email, password: _password);
        print('Signed In: $Id');
        setState(() {
          userId = Id;
          _isLoading = false;
        });
        if (userId.length > 0 && userId != null) {
          print("callback times");
          widget.loginCallback();
          Navigator.pop(context);
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Widget formCard() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: double.infinity,
      height: cardHeight,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.75),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.75),
                blurRadius: 10.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.75),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                  color: accentColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            showTextField(accentColor: accentColor),
            showPasswordField(accentColor: accentColor),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have account? ",
                    style: TextStyle(color: accentColor, fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: SignupPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showTextField({accentColor}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 20),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          //errorText: _validate ? 'Email can\'t be empty' : null,
          labelText: "Email",
          labelStyle: TextStyle(
            color: accentColor,
          ),
          focusColor: Colors.white,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: accentColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: accentColor, width: 2.5)),
        ),
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontFamily: "Baloo2", fontSize: 18),
        validator: (value) => value.isEmpty ? "Email not found" : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordField({accentColor}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 20),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          //errorText: _validate ? 'Email can\'t be empty' : null,
          labelText: "Password",
          labelStyle: TextStyle(
            color: accentColor,
          ),
          focusColor: Colors.white,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: accentColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: accentColor, width: 2.5)),
        ),
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(fontFamily: "Baloo2", fontSize: 18),
        validator: (value) => value.isEmpty ? "Password not found" : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }
}
