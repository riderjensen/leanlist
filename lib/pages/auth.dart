import 'dart:async';

import 'package:flutter/material.dart';

import '../scoped-models/main_model.dart';

class AuthPage extends StatefulWidget {
  final MainModel listModel;

  AuthPage(this.listModel);

  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

Future<void> _alertSignInIssue(BuildContext context, String message) async {
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

class _AuthPage extends State<AuthPage> {
  final Map<String, String> _formData = {'email': null, 'password': null};
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool buttonClicked = false;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.gif'),
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
                      'Lean List',
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
                    Text('Dont have an account?'),
                    GestureDetector(
                      child: Text('Sign Up'),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/sign_up');
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buttonClicked
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            child: Text('Log In'),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () async {
                              setState(() {
                                buttonClicked = true;
                              });
                              _formKey.currentState.save();
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              return await widget.listModel
                                  .signIn(
                                _formData['email'],
                                _formData['password'],
                              )
                                  .then((information) {
                                if (information['success'] == true) {
                                  setState(() {
                                    buttonClicked = false;
                                  });
                                  Navigator.of(context)
                                      .pushReplacementNamed('/lists');
                                } else {
                                  setState(() {
                                    buttonClicked = false;
                                  });
                                  _alertSignInIssue(
                                      context, information['message']);
                                }
                              });
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
