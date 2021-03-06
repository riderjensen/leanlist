import 'package:flutter/material.dart';
import '../scoped-models/main_model.dart';

class AddListDialog extends StatelessWidget {
  final Map<String, String> _formData = {'code': null};
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MainModel myModel;

  AddListDialog(this.myModel);

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
            _formKey.currentState.save();
            if (!_formKey.currentState.validate()) {
              return;
            }
            if (myModel.authUser.lists.contains(_formData['code'])) {
              return;
            } else {
              myModel.clearCurrentLists();
              myModel.authUser.lists.add(_formData['code']);
              myModel.setUserLists();
              myModel.updateUserInDB().then((_) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/home');
              });
            }
          },
        ),
      ],
    );
  }
}
