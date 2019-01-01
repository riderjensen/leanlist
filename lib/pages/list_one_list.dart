import 'package:flutter/material.dart';
import '../dummyData.dart';

class ListOneList extends StatelessWidget {
  final String listId;

  ListOneList(this.listId);

  Widget completedItems(Map<String, String> completeMaps) {
    return ListTile(
        leading: const Icon(Icons.flight_land),
        title: Text(completeMaps['item']),
        subtitle: Text(completeMaps['date']),
        onTap: () {/* react to the tile being tapped */});
  }

  Widget incompleteItems(String incompleteItems) {
    return ListTile(
        leading: const Icon(Icons.flight_land),
        title: Text(incompleteItems),
        onTap: () {/* react to the tile being tapped */});
  }

  Widget buildProgressItems(item) {
    return Container(
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, int) {
          return incompleteItems(item[int]);
        },
      ),
    );
  }

  Widget buildFinishedItems(item) {
    return Container(
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, int) {
          return completedItems(item[int]);
        },
      ),
    );
  }

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
            buildProgressItems(ourItem['items']['incomplete']),
            buildFinishedItems(ourItem['items']['complete'])
          ],
        ),
      ),
    );
  }
}
