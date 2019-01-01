import 'package:flutter/material.dart';

class ListOneList extends StatelessWidget {
  final String listId;

  ListOneList(this.listId);

  @override
  Widget build(BuildContext context) {
    // get the list from the DB
    return Scaffold(
        appBar: AppBar(
          title: Text('List Name'),
        ),
        body: Container(
          child: Text('Hello this is a new page'),
        ));
  }
}
