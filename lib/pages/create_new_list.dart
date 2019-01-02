import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../form_elements/create_radio_buttons.dart';

class CreateNewList extends StatelessWidget {
  final Map<String, dynamic> formData = {
    'id': null,
    'shareId': null,
    'title': null,
    'creator': 'Rider',
    'permissions': null,
    'items': {'incomplete': [], 'complete': []}
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new list'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Enter a title'),
                  TextFormField(
                    onSaved: (String value) {
                      formData['title'] = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A title is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Choose list permissions'),
                  SizedBox(
                    height: 10,
                  ),
                  CreateRadioButtons(formData),
                  FlatButton(
                    color: Colors.blue,
                    child: Text('Create'),
                    onPressed: () {
                      _formKey.currentState.save();
                      if (!_formKey.currentState.validate() ||
                          formData['permissions'] == null) {
                        return;
                      }
                      final Uuid uuid = new Uuid();
                      final String newID = uuid.v1();
                      formData['id'] = newID;
                      formData['shareId'] = newID.split('-')[0];

                      print(formData);
                      // assign id?
                      // add to local list now?
                      // await putting into db
                      // push new home page with updated lists
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
