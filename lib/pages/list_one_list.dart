import 'package:flutter/material.dart';
import '../dummyData.dart';

class ListOneList extends StatelessWidget {
  final String listId;

  ListOneList(this.listId);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ourItem = ourList[int.parse(listId)];
    return Scaffold(
      appBar: AppBar(
        title: Text(ourItem['title']),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: ourItem['incomplete'].length,
          itemBuilder: (context, int) {},
        ),
      ),
    );
  }
}
