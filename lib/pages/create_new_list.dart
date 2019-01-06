import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../resources/icon_list.dart';

class CreateNewList extends StatefulWidget {
  final List ourList;

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

void _resetColor() {
  for (List i in icons) {
    i.forEach((f) => f['color'] = [158, 158, 158]);
  }
}

class _CreateNewList extends State<CreateNewList> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _resetColor();
    super.initState();
  }

  Widget _returnText(wording) {
    return Text(wording);
  }

  Widget _returnIconChooseArea(BuildContext context) {
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
        _returnText('Choose an icon'),
        Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
            itemCount: icons.length,
            itemBuilder: (context, int) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.formData['icon'] = icons[int][0]['icon'];
                        _resetColor();
                        icons[int][0]['color'] = [100, 181, 246];
                      });
                    },
                    icon: Icon(
                      IconData(icons[int][0]['icon'],
                          fontFamily: 'MaterialIcons'),
                      color: Color.fromRGBO(
                          icons[int][0]['color'][0],
                          icons[int][0]['color'][1],
                          icons[int][0]['color'][2],
                          1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.formData['icon'] = icons[int][1]['icon'];
                        _resetColor();
                        icons[int][1]['color'] = [100, 181, 246];
                      });
                    },
                    icon: Icon(
                      IconData(icons[int][1]['icon'],
                          fontFamily: 'MaterialIcons'),
                      color: Color.fromRGBO(
                          icons[int][1]['color'][0],
                          icons[int][1]['color'][1],
                          icons[int][1]['color'][2],
                          1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.formData['icon'] = icons[int][2]['icon'];
                        _resetColor();
                        icons[int][2]['color'] = [100, 181, 246];
                      });
                    },
                    icon: Icon(
                      IconData(icons[int][2]['icon'],
                          fontFamily: 'MaterialIcons'),
                      color: Color.fromRGBO(
                          icons[int][2]['color'][0],
                          icons[int][2]['color'][1],
                          icons[int][2]['color'][2],
                          1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.formData['icon'] = icons[int][3]['icon'];
                        _resetColor();
                        icons[int][3]['color'] = [100, 181, 246];
                      });
                    },
                    icon: Icon(
                      IconData(icons[int][3]['icon'],
                          fontFamily: 'MaterialIcons'),
                      color: Color.fromRGBO(
                          icons[int][3]['color'][0],
                          icons[int][3]['color'][1],
                          icons[int][3]['color'][2],
                          1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.formData['icon'] = icons[int][4]['icon'];
                        _resetColor();
                        icons[int][4]['color'] = [100, 181, 246];
                      });
                    },
                    icon: Icon(
                      IconData(icons[int][4]['icon'],
                          fontFamily: 'MaterialIcons'),
                      color: Color.fromRGBO(
                          icons[int][4]['color'][0],
                          icons[int][4]['color'][1],
                          icons[int][4]['color'][2],
                          1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.formData['icon'] = icons[int][5]['icon'];
                        _resetColor();
                        icons[int][5]['color'] = [100, 181, 246];
                      });
                    },
                    icon: Icon(
                      IconData(icons[int][5]['icon'],
                          fontFamily: 'MaterialIcons'),
                      color: Color.fromRGBO(
                          icons[int][5]['color'][0],
                          icons[int][5]['color'][1],
                          icons[int][5]['color'][2],
                          1),
                    ),
                  ),
                ],
              );
            },
          ),
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
                widget.formData['fullPermissions'] == null) {
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
        child: Form(key: _formKey, child: _returnIconChooseArea(context)),
      ),
    );
  }
}
