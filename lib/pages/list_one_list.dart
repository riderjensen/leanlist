import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/list_model.dart';
import '../ui_elements/completed_list_tile.dart';
import '../ui_elements/incomplete_list_tile.dart';
import '../scoped-models/main_model.dart';

class ListOneList extends StatefulWidget {
  final MainModel listModel;
  final Map<String, String> _formData = {'item': null};

  ListOneList(this.listModel);
  @override
  State<StatefulWidget> createState() {
    return _ListOneList();
  }
}

class _ListOneList extends State<ListOneList> {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _createShareAlert(
      BuildContext context, String firbaseId, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tap for your Share ID'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                    child: Text(firbaseId),
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: firbaseId));
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _createAddItemDialog(BuildContext context, List incompleteList) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter a task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onSaved: (String value) {
                          widget._formData['item'] = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter a task for your list ';
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
                setState(() {
                  incompleteList.add(widget._formData['item']);
                });
                widget.listModel.updateListInDB();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ListModel ourItem = widget.listModel.getOneList;
    final String authUsername = widget.listModel.authUser.username;
    final key = new GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(ourItem.title),
          actions: ourItem.fullPermissions == false &&
                  ourItem.creator != authUsername
              ? null
              : <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      _createShareAlert(context, ourItem.firebaseId, key);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _createAddItemDialog(
                            context, ourItem.items['incomplete']);
                      });
                    },
                  ),
                ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'In Progress Items',
                icon: Icon(Icons.create),
              ),
              Tab(
                text: 'Finished Items',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            IncompleteListTile(
                widget.listModel.getOneList.items,
                widget.listModel.authUser.username,
                widget.listModel.updateListInDB),
            CompletedListTile(widget.listModel.getOneList.items,
                widget.listModel.updateListInDB)
          ],
        ),
      ),
    );
  }
}
