import 'package:flutter/material.dart';
import '../models/list_model.dart';

class MainListCard extends StatefulWidget {
  final List<ListModel> ourList;

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
                leading: Icon(IconData(widget.ourList[int].icon,
                    fontFamily: 'MaterialIcons')),
                title: Text(widget.ourList[int].title),
                subtitle: Text('Creator: ${widget.ourList[int].creator}'),
                onTap: () {
                  Navigator.pushNamed<dynamic>(
                      context, '/list/' + int.toString());
                }),
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
