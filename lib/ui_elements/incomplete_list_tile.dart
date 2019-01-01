import 'package:flutter/material.dart';

class IncompleteListTile extends StatefulWidget {
  final Map<String, List<Object>> ourList;

  IncompleteListTile(this.ourList);

  @override
  State<StatefulWidget> createState() {
    return _IncompleteListTile();
  }
}

class _IncompleteListTile extends State<IncompleteListTile> {
  @override
  Widget build(BuildContext context) {
    final List<Object> items = widget.ourList['incomplete'];
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int) {
          return Dismissible(
            key: Key(items[int]),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd ||
                  direction == DismissDirection.endToStart) {
                items.removeAt(int);
                // update db
              }
            },
            background: Container(
              color: Colors.red,
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.check_box_outline_blank),
                    title: Text(items[int]),
                    onTap: () {
                      widget.ourList['complete'].add({
                        'item': items[int].toString(),
                        'date': new DateTime.now().toLocal().toString(),
                        'userCom': 'Rider'
                      });
                      setState(() {
                        items.removeAt(int);
                      });
                      // update the DB with the corrected information
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
