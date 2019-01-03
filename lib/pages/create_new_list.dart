import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../form_elements/create_radio_buttons.dart';
import '../form_elements/icon_chooser.dart';

class CreateNewList extends StatelessWidget {
  final Map<String, dynamic> formData = {
    'id': null,
    'shareId': null,
    'title': null,
    'icon': 57744,
    'creator': 'Rider',
    'permissions': null,
    'items': {
      'incomplete': [],
      'complete': [{}]
    }
  };
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List ourList;
  CreateNewList(this.ourList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new list'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(
                height: 10,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: IconChooser(formData),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                textColor: Colors.white,
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
                  ourList.add(formData);
                  // await putting into db
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
