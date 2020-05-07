import 'package:bloodbank/login_signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  Color background = Color(0xFFF3D4DA);
  Color accentColor = Color(0xFF584d9b);
  String _email, _password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validate = false;

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
          appBar: AppBar(
            backgroundColor: background,
            elevation: 0,
            actions: <Widget>[FlatButton(child: Text("Don't have account? Sign Up", style: TextStyle(color: accentColor, fontSize: 15),), onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SignupPage()));
            },),],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: 330,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loginback.png'),
                        fit: BoxFit.fitWidth),
                  ),
                  
                ),
                showTextField(),
                showPasswordField(),
                showButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: RaisedButton(
        padding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF968fbc),
              Color(0xFFD1CFDA),
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
          validateAndSubmit();
        },
      ),
    );
  }

  Widget showTextField() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          //errorText: _validate ? 'Email can\'t be empty' : null,
          labelText: "Enter Email",
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
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontFamily: "Baloo2"),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Enter Password",
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
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        style: TextStyle(fontFamily: "Baloo2"),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (_formKey.currentState.validate()) {
      // setState(() {
      //   _errorMessage = "";
      //   _isLoading = true;
      // });
    }
    if (validateAndSave()) {
      String userId = "";
      print("clicked");
      try {
        // if (isLoginForm) {
        //   userId = await widget.auth.signIn(_email, _password);
        //   print('Signed In: $userId');
        // } else {
        //   userId = await widget.auth.signUp(_email, _password);
        //   print('Signed Up User: $userId');
        // }
        // setState(() {
        //   _isLoading = false;
        // });
        // if (userId.length > 0 && userId != null && isLoginForm) {
        //   widget.loginCallback();
        // }
      } catch (e) {
        print('Error: $e');
        setState(() {
          // _isLoading = false;
          // _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
