import 'dart:async';

import 'package:flutter/material.dart';

import '../scoped-models/main_model.dart';

class SignUp extends StatefulWidget {
  final MainModel listModel;

  SignUp(this.listModel);

  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

Future<void> _alertSignUpIssue(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class _SignUp extends State<SignUp> {
  final Map<String, String> _formData = {
    'username': null,
    'email': null,
    'password': null
  };
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.gif'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign Up On Lean List',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onSaved: (String value) {
                        _formData['email'] = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'An email is required';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      onSaved: (String value) {
                        _formData['username'] = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'A username is required';
                        }
                        if (value.length <= 2) {
                          return 'Username must be longer than 2 characters';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _formData['password'] = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'A password is required';
                        }
                        if (value.length <= 5) {
                          return 'Password must be longer than 5 characters';
                        }
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Already have an account?'),
                    GestureDetector(
                      child: Text('Sign In'),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/auth');
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Sign Up'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        final Map<String, dynamic> information =
                            await widget.listModel.signUp(
                          _formData['username'],
                          _formData['email'],
                          _formData['password'],
                        );
                        if (information['success'] == true) {
                          Navigator.of(context).pushReplacementNamed('/lists');
                        } else {
                          _alertSignUpIssue(context, information['message']);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
