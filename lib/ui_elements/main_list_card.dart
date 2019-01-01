import 'package:flutter/material.dart';

class MainListCard extends StatefulWidget {
  final List ourList;

  MainListCard(this.ourList);

  @override
  State<StatefulWidget> createState() {
    return _MainListCard();
  }
}

class _MainListCard extends State<MainListCard> {
  Widget returnCard(int) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(widget.ourList[int]['title']),
              subtitle: Text('Creator: ${widget.ourList[int]['creator']}'),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('View'),
                    onPressed: () {
                      Navigator.pushNamed<dynamic>(
                          context, '/list/' + widget.ourList[int]['id']);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.ourList.length,
      itemBuilder: (context, int) {
        return returnCard(int);
      },
    );
  }
}
