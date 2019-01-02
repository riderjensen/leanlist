import 'package:flutter/material.dart';
import '../dummyData.dart';

import '../ui_elements/completed_list_tile.dart';
import '../ui_elements/incomplete_list_tile.dart';

class ListOneList extends StatelessWidget {
  final String listId;

  ListOneList(this.listId);

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

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> ourItem = ourList[int.parse(listId)];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(ourItem['title']),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                _createShareAlert(context, ourItem['shareId']);
              },
            )
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
            IncompleteListTile(ourItem['items']),
            CompletedListTile(ourItem['items']),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          heroTag: 'contact',
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}
