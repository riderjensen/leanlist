import 'package:flutter/material.dart';

import '../resources/icon_list.dart';
import '../models/list_model.dart';
import '../scoped-models/main_model.dart';

class CreateNewList extends StatefulWidget {
  final MainModel _listModel;

  CreateNewList(this._listModel);

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

class _CreateNewList extends State<CreateNewList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Map<String, dynamic> formData = {
    'fullPermissions': true,
    'icon': 0xe192,
  };

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool firstPage = true;

  @override
  void initState() {
    _resetColor();
    super.initState();
  }

  Widget _returnText(wording) {
    return Text(wording);
  }

  Widget _returnIconArea(BuildContext context) {
    return Column(
      children: <Widget>[
        new Expanded(
          child: ListView.builder(
            itemCount: icons.length,
            itemBuilder: (context, int) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        formData['icon'] = icons[int][0]['icon'];
                        _resetColor();
                        icons[int][0]['color'] = [121, 15, 72];
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
                        formData['icon'] = icons[int][1]['icon'];
                        _resetColor();
                        icons[int][1]['color'] = [121, 15, 72];
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
                        formData['icon'] = icons[int][2]['icon'];
                        _resetColor();
                        icons[int][2]['color'] = [121, 15, 72];
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
                        formData['icon'] = icons[int][3]['icon'];
                        _resetColor();
                        icons[int][3]['color'] = [121, 15, 72];
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
                        formData['icon'] = icons[int][4]['icon'];
                        _resetColor();
                        icons[int][4]['color'] = [121, 15, 72];
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
                        formData['icon'] = icons[int][5]['icon'];
                        _resetColor();
                        icons[int][5]['color'] = [121, 15, 72];
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
          color: Theme.of(context).primaryColor,
          child: Text('Create'),
          onPressed: () {
            final ListModel newestAddition = new ListModel(
              creator: widget._listModel.authUser.username,
              icon: formData['icon'],
              title: formData['title'],
              fullPermissions: formData['fullPermissions'],
              toggleDelete: false,
              items: {'incomplete': [], 'complete': []},
            );
            widget._listModel.addToUserLists(newestAddition).then((_) {
              widget._listModel.updateListInDB().then((onValue) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/home');
              });
            });
          },
        )
      ],
    );
  }

  Widget _returnIconChooseArea(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _returnText('Enter a title'),
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
          height: 10,
        ),
        _returnText('Choose list permissions'),
        Container(
          child: SwitchListTile(
            value: formData['fullPermissions'],
            onChanged: (bool value) {
              setState(() {
                formData['fullPermissions'] = value;
              });
            },
            title: formData['fullPermissions']
                ? Text('Full permissions')
                : Text('Limited Permissions'),
          ),
        ),
        Container(
          child: formData['fullPermissions']
              ? Text('Anyone can edit, delete, and invite people to this list')
              : Text(
                  'Permissions are limited to the creator of the list. Users can still be invited and complete tasks.'),
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text('Next'),
          onPressed: () {
            _formKey.currentState.save();
            if (!_formKey.currentState.validate() ||
                formData['fullPermissions'] == null) {
              return;
            }
            setState(() {
              firstPage = false;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
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
            child: firstPage == true
                ? _returnIconChooseArea(context)
                : _returnIconArea(context)),
      ),
    );
  }
}
