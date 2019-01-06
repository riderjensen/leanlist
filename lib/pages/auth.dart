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

class _AuthPage extends State<AuthPage> {
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
                        color: Colors.blue,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onSaved: (String value) {
                        _formData['username'] = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'A username is required';
                        }
                        if (value.length <= 5) {
                          return 'Username must be longer than 5 characters';
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
                    RaisedButton(
                      child: Text('Log In'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        _formKey.currentState.save();
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        widget.listModel.signIn(
                          _formData['username'],
                          _formData['password'],
                        );
                        Navigator.of(context).pushReplacementNamed('/lists');
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
