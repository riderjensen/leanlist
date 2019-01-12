import 'package:flutter/material.dart';

class NoSwipeCompletedListTile extends StatefulWidget {
  final Map<String, dynamic> ourList;
  final Function updateListInDB;

  NoSwipeCompletedListTile(this.ourList, this.updateListInDB);
  @override
  State<StatefulWidget> createState() {
    return _NoSwipeCompletedListTile();
  }
}

class _NoSwipeCompletedListTile extends State<NoSwipeCompletedListTile> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = widget.ourList['complete'];

    return items.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('You have no completed items'),
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
                        leading: const Icon(Icons.check_box),
                        title: Text(
                          items[int]['item'],
                        ),
                        subtitle: Text(
                            'Completed by: ${items[int]['userCom']} - ${items[int]['date']}'),
                        onTap: () {
                          widget.ourList['incomplete'].add(items[int]['item']);
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
