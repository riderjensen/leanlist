import 'package:flutter/material.dart';

class CompletedListTile extends StatefulWidget {
  final Map<String, List<Object>> ourList;

  CompletedListTile(this.ourList);
  @override
  State<StatefulWidget> createState() {
    return _CompletedListTile();
  }
}

class _CompletedListTile extends State<CompletedListTile> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = widget.ourList['complete'];
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int) {
          return Dismissible(
            key: Key(items[int]['title']),
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