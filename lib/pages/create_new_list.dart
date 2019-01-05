import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../form_elements/icon_chooser.dart';

class CreateNewList extends StatefulWidget {
  final List ourList;
  bool firstPart = false;

  final Map<String, dynamic> formData = {
    'id': null,
    'shareId': null,
    'title': null,
    'icon': 57744,
    'creator': 'Rider',
    'fullPermissions': false,
    'items': {
      'incomplete': [],
      'complete': [{}]
    }
  };

  CreateNewList(this.ourList);

  @override
  State<StatefulWidget> createState() {
    return _CreateNewList();
  }
}

class _CreateNewList extends State<CreateNewList> {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _returnText(wording) {
    return Text(wording);
  }

  Widget _returnTitleAndPermissions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _returnText('Enter a title'),
        TextFormField(
          onSaved: (String value) {
            widget.formData['title'] = value;
          },
          validator: (String value) {
            if (value.isEmpty) {
              return 'A title is required';
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        _returnText('Choose list permissions'),
        Container(
          child: SwitchListTile(
            value: widget.formData['fullPermissions'],
            onChanged: (bool value) {
              setState(() {
                widget.formData['fullPermissions'] = value;
              });
            },
            title: widget.formData['fullPermissions']
                ? Text('Full permissions')
                : Text('Limited Permissions'),
          ),
        ),
        Container(
          child: widget.formData['fullPermissions']
              ? Text('Anyone can edit, delete, and invite people to this list')
              : Text(
                  'Permissions are limited to the creator of the list. Users can still be invited and complete tasks.'),
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('Next'),
          onPressed: () {
            _formKey.currentState.save();
            if (!_formKey.currentState.validate() ||
                widget.formData['permissions'] == null) {
              return;
            }
            setState(() {
              widget.firstPart = true;
            });
            // await putting into db
          },
        )
      ],
    );
  }

  Widget _returnIconChooseArea(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _returnText('Choose an icon'),
        Flexible(
          fit: FlexFit.loose,
          child: IconChooser(widget.formData),
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
                widget.formData['permissions'] == null) {
              return;
            }
            final Uuid uuid = new Uuid();
            final String newID = uuid.v1();
            widget.formData['id'] = newID;
            widget.formData['shareId'] = newID.split('-')[0];
            widget.ourList.add(widget.formData);
            // await putting into db
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

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
            child: !widget.firstPart
                ? _returnTitleAndPermissions(context)
                : _returnIconChooseArea(context)),
      ),
      bottomSheet: LinearProgressIndicator(
        value: !widget.firstPart ? 0.5 : 1.0,
      ),
    );
  }
}
