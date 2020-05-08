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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _email, _password, _name, _phone;

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
              showTextField(
                  labelText: "Enter Name",
                  obsecureText: false,
                  errorMsg: "Name not found!",
                  controller: _nameController,
                  variable: _name,
                  inputType: TextInputType.text),
              showTextField(
                  labelText: "Enter Phone Number",
                  obsecureText: false,
                  errorMsg: "Name not found!",
                  controller: _phoneController,
                  variable: _phone,
                  inputType: TextInputType.number),
              showTextField(
                  labelText: "Enter Email",
                  obsecureText: false,
                  errorMsg: "Email can't be empty",
                  controller: _emailController,
                  variable: _email,
                  inputType: TextInputType.emailAddress),
              showTextField(
                  labelText: "Enter Password",
                  obsecureText: true,
                  errorMsg: "Password can't be empty",
                  controller: _passwordController,
                  variable: _password,
                  inputType: TextInputType.emailAddress),
                  showButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showTextField(
      {labelText, obsecureText, errorMsg, controller, variable, inputType}) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          //errorText: _validate ? 'Email can\'t be empty' : null,
          labelText: labelText,
          labelStyle: TextStyle(
            color: accentColor,
          ),
          focusColor: Colors.white,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: accentColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: accentColor, width: 2)),
        ),
        obscureText: obsecureText,
        maxLines: 1,
        keyboardType: inputType,
        style: TextStyle(fontFamily: "Baloo2", fontSize: 18),
        validator: (value) => value.isEmpty ? errorMsg : null,
        onSaved: (value) => variable = value.trim(),
      ),
    );
  }
    Widget showButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      child: RaisedButton(
        padding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFe5798d),
              Color(0xFFF3D4DA),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Login", //Color(0xFF212121)
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () {
          // setState(() {
          //   _emailController.text.isEmpty
          //       ? _validate = true
          //       : _validate = false;
          // });
//          validateAndSubmit();
        },
      ),
    );
  }

}
