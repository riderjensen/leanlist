import 'package:flutter/material.dart';

class CompletedListTile extends StatefulWidget {
  final Map<String, dynamic> ourList;
  final Function updateListInDB;

  CompletedListTile(this.ourList, this.updateListInDB);
  @override
  State<StatefulWidget> createState() {
    return _CompletedListTile();
  }
}

class _CompletedListTile extends State<CompletedListTile> {
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
                return Dismissible(
                  key: Key(items[int]['title']),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.startToEnd ||
                        direction == DismissDirection.endToStart) {
                      setState(() {
                        items.removeAt(int);
                      });
                      widget.updateListInDB();
                    }
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.check_box,
                              color: Theme.of(context).primaryColor),
                          title: Text(
                            items[int]['item'],
                          ),
                          subtitle: Text(
                              'Completed by: ${items[int]['userCom']} - ${items[int]['date']}'),
                          onTap: () {
                            widget.ourList['incomplete']
                                .add(items[int]['item']);
                            setState(() {
                              items.removeAt(int);
                            });
                            widget.updateListInDB();
                          }),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
