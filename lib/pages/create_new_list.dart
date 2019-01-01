import 'package:flutter/material.dart';

class CreateNewList extends StatelessWidget {
  final Map<String, dynamic> _formData = {
    'id': null,
    'title': null,
    'creator': 'Rider',
    'permissions': null,
    'items': {'incomplete': [], 'complete': []}
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String myVal = 'Null';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new list'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Enter a title'),
                  TextFormField(
                    onSaved: (String value) {
                      _formData['title'] = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A title is required';
                      }
                    },
                  ),
                  Text('Choose list permissions'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        onChanged: (value) {
                          myVal = value;
                        },
                        groupValue: myVal,
                        value: 'Full',
                      ),
                      Text('Full permissions')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        onChanged: (value) {
                          myVal = value;
                        },
                        groupValue: myVal,
                        value: 'Partial',
                      ),
                      Text('Limited permissions')
                    ],
                  ),
                  FlatButton(
                    child: Text('Create'),
                    onPressed: () {
                      print('create');
                      _formKey.currentState.save();
                      if (!_formKey.currentState.validate() || myVal == null) {
                        return;
                      }
                      _formData['permissions'] = myVal;
                      // assign id?
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
