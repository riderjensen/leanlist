import 'package:flutter/material.dart';

import '../models/list_model.dart';
import '../scoped-models/main_model.dart';

class MainListCard extends StatefulWidget {
  final MainModel theMainModel;

  MainListCard(this.theMainModel);

  @override
  State<StatefulWidget> createState() {
    return _MainListCard();
  }
}

class _MainListCard extends State<MainListCard> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool ourCardDelete = false;
  Widget _oneSideCard(int, List<ListModel> ourList) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(
              IconData(ourList[int].icon, fontFamily: 'MaterialIcons'),
            ),
            title: Text(ourList[int].title),
            subtitle: Text('Creator: ${ourList[int].creator}'),
            onTap: () {
              Navigator.pushNamed<dynamic>(context, '/list/' + ourList[int].id);
            }),
      ],
    );
  }

  Widget _deleteSideCard(int, List<ListModel> ourList) {
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
                setState(() {
                  widget.theMainModel.removeAList(ourList[int].shareId);
                });
              },
            ),
            title: Text(ourList[int].title),
            subtitle: Text('Creator: ${ourList[int].creator}'),
          ),
        )
      ],
    );
  }

  Widget returnCard(int, List<ListModel> ourList) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          ourList[int].toggleDelete = !ourList[int].toggleDelete;
        });
      },
      child: Center(
        child: Card(
            child: ourList[int].toggleDelete
                ? _deleteSideCard(int, ourList)
                : _oneSideCard(int, ourList)),
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
    final List<ListModel> ourList = widget.theMainModel.userLists;

    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: ourList.length,
          itemBuilder: (context, int) {
            return returnCard(int, ourList);
          },
        ));
  }
}
