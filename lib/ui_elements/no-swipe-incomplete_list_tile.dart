import 'package:flutter/material.dart';

class NoSwipeIncompleteListTile extends StatefulWidget {
  final Map<String, dynamic> ourList;
  final String username;
  final Function updateListInDB;

  NoSwipeIncompleteListTile(this.ourList, this.username, this.updateListInDB);

  @override
  State<StatefulWidget> createState() {
    return _NoSwipeIncompleteListTile();
  }
}

class _NoSwipeIncompleteListTile extends State<NoSwipeIncompleteListTile> {
  @override
  Widget build(BuildContext context) {
    final List<Object> items = widget.ourList['incomplete'];
    return items == null || items.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    'You have no items here. Use the button above to add some'),
              )
            ],
          )
        : Container(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, int) {
                return Column(
                  children: <Widget>[
                    ListTile(
                        leading: const Icon(Icons.check_box_outline_blank),
                        title: Text(items[int]),
                        onTap: () {
                          final DateTime date = new DateTime.now().toLocal();
                          final String dateCompleted =
                              '${date.month}/${date.day}/${date.year} ${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute} ${date.hour > 12 ? 'pm' : 'am'}';
                          widget.ourList['complete'].add({
                            'item': items[int].toString(),
                            'date': dateCompleted,
                            'userCom': widget.username
                          });
                          setState(() {
                            items.removeAt(int);
                          });
                          widget.updateListInDB();
                        }),
                    Divider(),
                  ],
                );
              },
            ),
          );
  }
}
