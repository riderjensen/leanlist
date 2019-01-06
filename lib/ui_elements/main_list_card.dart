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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
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

  Future<void> _refresh() {
    return Future.delayed(
        Duration(seconds: 1),
        () =>
            'Our future returning that will contact the db and get updated lists');
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: widget.ourList.length,
          itemBuilder: (context, int) {
            return returnCard(int);
          },
        ));
  }
}
