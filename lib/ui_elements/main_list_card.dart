import 'package:flutter/material.dart';
import '../models/list_model.dart';
import '../models/user.dart';

class MainListCard extends StatefulWidget {
  final List<ListModel> ourList;
  final UserModel ourUser;

  MainListCard(this.ourList, this.ourUser);

  @override
  State<StatefulWidget> createState() {
    return _MainListCard();
  }
}

class _MainListCard extends State<MainListCard> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool ourCardDelete = false;

  Widget _oneSideCard(int) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(
              IconData(widget.ourList[int].icon, fontFamily: 'MaterialIcons'),
            ),
            title: Text(widget.ourList[int].title),
            subtitle: Text('Creator: ${widget.ourList[int].creator}'),
            onTap: () {
              Navigator.pushNamed<dynamic>(context, '/list/' + int.toString());
            }),
      ],
    );
  }

  Widget _deleteSideCard(int) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 0, 0, 0.3)),
          child: ListTile(
            leading: IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                // remove this item from the list
              },
            ),
            title: Text(widget.ourList[int].title),
            subtitle: Text('Creator: ${widget.ourList[int].creator}'),
          ),
        )
      ],
    );
  }

  Widget returnCard(int) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          widget.ourList[int].toggleDelete = !widget.ourList[int].toggleDelete;
        });
      },
      child: Center(
        child: Card(
            child: widget.ourList[int].toggleDelete
                ? _deleteSideCard(int)
                : _oneSideCard(int)),
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
