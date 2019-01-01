import 'package:flutter/material.dart';
import '../dummyData.dart';

import '../ui_elements/completed_list_tile.dart';
import '../ui_elements/incomplete_list_tile.dart';

class ListOneList extends StatelessWidget {
  final String listId;

  ListOneList(this.listId);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ourItem = ourList[int.parse(listId)];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(ourItem['title']),
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
      ),
    );
  }
}
