import 'package:bloodbank/login_signup/login.dart';
import 'package:bloodbank/models/user.dart';
import 'package:bloodbank/services/authentication.dart';
import 'package:bloodbank/widgets/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

Widgets widgets = Widgets();

class SignupPage extends StatefulWidget {
  final BaseAuth auth;

  const SignupPage({Key key, this.auth}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;

  final _formKey = new GlobalKey<FormState>();

  Color background = Color(0xFFD1CFDA);
  Color accentColor = Color(0xFFef889b);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _email, _password, _name, _phone, _bloodgroup;
  List<String> items = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  List<DropdownMenuItem<String>> _dropdownItems;
  double cardHeight = 550;
  String _userId = "";
  String _errorMessage = "";
  bool _isLoading = false;
  @override
  void initState() {
    _dropdownItems = buildDropDownItems(items);
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropDownItems(List itemsList) {
    List<DropdownMenuItem<String>> items = List();
    for (String item in itemsList) {
      items.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'heroSignup',
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: background,
          body: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 230,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/signupbackground.png'),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ]),
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      formCard(),
                      SizedBox(
                        height: 20,
                      ),
                      widgets.signupButton(onPressed: validateAndSubmit),
                      SizedBox(
                        height: 20,
                      ),
                      showErrorMessage(),
                      SizedBox(
                        height: 10,
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

  Widget dropdown() {
    Color color = Color(0xFFef889b);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 35, bottom: 10, top: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: color),
              borderRadius: BorderRadius.circular(20)),
          child: DropdownButton(
            focusColor: accentColor,
            hint: Text(
              'Select your blood group',
              style: TextStyle(color: color),
            ),
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            value: _bloodgroup,
            icon: Icon(
              Icons.arrow_downward,
              color: color,
            ),
            iconSize: 24,
            items: _dropdownItems,
            onChanged: onChangedDropdownItem,
          ),
        ),
      ),
    );
  }

  onChangedDropdownItem(String value) {
    setState(() {
      _bloodgroup = value;
    });
    Fluttertoast.showToast(msg: _bloodgroup, toastLength: Toast.LENGTH_SHORT);
  }

  Widget formCard() {
    double offset = 0;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: double.infinity,
      height: cardHeight,
      margin: EdgeInsets.only(top: 120),
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, offset),
                spreadRadius: 10.0,
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, offset),
                blurRadius: 10.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, offset),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Register",
              style: TextStyle(
                  color: Color(0xFFef889b),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            widgets.showTextField(
                labelText: "Name",
                obsecureText: false,
                inputType: TextInputType.text,
                controller: _nameController,
                errorMsg: "Name not given",
                variable: _name,
                accentColor: accentColor),
            widgets.showTextField(
                labelText: "Phone",
                inputType: TextInputType.phone,
                obsecureText: false,
                controller: _phoneController,
                errorMsg: "Phone number not found",
                variable: _phone,
                accentColor: accentColor),
            widgets.showTextField(
                labelText: "Email",
                obsecureText: false,
                inputType: TextInputType.emailAddress,
                controller: _emailController,
                errorMsg: "Email not found",
                variable: _email,
                accentColor: accentColor),
            widgets.showTextField(
                labelText: "Password",
                obsecureText: true,
                inputType: TextInputType.text,
                controller: _passwordController,
                errorMsg: "Password not found",
                variable: _password,
                accentColor: accentColor),
            dropdown(),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: RichText(
                  text: TextSpan(
                    text: "Already have account? ",
                    style: TextStyle(color: accentColor, fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Login",
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
                        type: PageTransitionType.fade, child: LoginPage()),
                  );
                },
              ),
            ),
          ],
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

  void saveValues() {
    _name = _nameController.text.trim();
    _phone = _phoneController.text.trim();
    _email = _emailController.text.trim();
    _password = _passwordController.text.trim();
    _bloodgroup = _bloodgroup;
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      saveValues();
      setState(() {
        cardHeight = 550;
        accentColor = Color(0xFFef889b);
      });
      Fluttertoast.showToast(msg: _nameController.text.toString());
      return true;
    } else {
      setState(() {
        cardHeight = 670;
        accentColor = Color(0xFF584d9b);
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
      try {
        _userId = await widget.auth.signUp(email: _email, password: _password);
        print('Signed Up User: $_userId');
        signUpUser(
            userId: _userId,
            name: _name,
            phone: _phone,
            email: _email,
            bloodgroup: _bloodgroup);
        setState(() {
          _isLoading = false;
        });
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

  signUpUser(
      {String userId,
      String name,
      String phone,
      String email,
      String bloodgroup}) {
    User user = User(
        userId: userId,
        name: name,
        phone: phone,
        email: email,
        bloodgroup: bloodgroup);
    _database.reference().child("Users").child(userId).set(user.toJson());
  }
}
