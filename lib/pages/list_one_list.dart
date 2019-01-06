import 'package:flutter/material.dart';

import '../models/list_model.dart';
import '../ui_elements/completed_list_tile.dart';
import '../ui_elements/incomplete_list_tile.dart';

class ListOneList extends StatefulWidget {
  final ListModel oneList;
  final Map<String, String> _formData = {'item': null};

  ListOneList(this.oneList);
  @override
  State<StatefulWidget> createState() {
    return _ListOneList();
  }
}

class _ListOneList extends State<ListOneList> {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _createShareAlert(BuildContext context, String shareId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Share ID'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(shareId),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
    ListModel ourItem = widget.oneList;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(ourItem.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                _createShareAlert(context, ourItem.shareId);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _createAddItemDialog(context, ourItem.items['incomplete']);
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
            IncompleteListTile(ourItem.items),
            CompletedListTile(ourItem.items),
          ],
        ),
      ),
    );
  }
}
