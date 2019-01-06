import 'package:flutter/material.dart';

class AddListDialog extends StatelessWidget {
  final Map<String, String> _formData = {'code': null};
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter a code'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Enter the code you were given'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    onSaved: (String value) {
                      _formData['code'] = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A code is required';
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            // await finding the list and adding them to it
            _formKey.currentState.save();
            if (!_formKey.currentState.validate()) {
              return;
            }
            // this push isnt working, need to basically refresh the home page
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
