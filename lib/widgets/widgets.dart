import 'package:flutter/material.dart';

class Widgets {
  Widget loginButton({Function onPressed}) {
    return InkWell(
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF8179b2),
              Color(0xFF8179b2),
              // Color(0xFFD1CFDA),
            ]),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF6078ea).withOpacity(.3),
                  offset: Offset(0.0, 8.0),
                  blurRadius: 8.0)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
Widget signupButton({Function onPressed}) {
    return InkWell(
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
             Color(0xFFef889b),
              Color(0xFFef889b),
              // Color(0xFFD1CFDA),
            ]),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF6078ea).withOpacity(.3),
                  offset: Offset(0.0, 8.0),
                  blurRadius: 8.0)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text(
                "Register",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showTextField(
      {labelText, obsecureText, inputType, errorMsg, controller, variable, accentColor}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 20),
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
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: accentColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: accentColor, width: 2.5)),
        ),
        obscureText: obsecureText,
        keyboardType: inputType,
        style: TextStyle(fontFamily: "Baloo2", fontSize: 18),
        validator: (value) => value.isEmpty ? errorMsg : null,
        onSaved: (value) => variable = value.trim(),
      ),
    );
  }
}
