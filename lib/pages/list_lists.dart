import 'package:flutter/material.dart';

import '../scoped-models/main_model.dart';
import '../ui_elements/main_list_card.dart';

class ListLists extends StatefulWidget {
  final MainModel _listModel;

  ListLists(this._listModel);

  @override
  State<StatefulWidget> createState() {
    return _ListLists();
  }
}

class _ListLists extends State<ListLists> {
  Widget returnEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('No lists currently created.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget._listModel.userLists == null ||
                widget._listModel.userLists.isEmpty
            ? returnEmpty()
            : MainListCard(widget._listModel));
  }
}
