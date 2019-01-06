import 'package:flutter/material.dart';

import '../scoped-models/main_model.dart';
import '../ui_elements/main_list_card.dart';

class ListLists extends StatefulWidget {
  final MainModel listModel;

  ListLists(this.listModel);

  @override
  State<StatefulWidget> createState() {
    return _ListLists();
  }
}

class _ListLists extends State<ListLists> {
  Widget returnEmpty() {
    print(widget.listModel.toString());

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
        child: widget.listModel.userLists() == null
            ? returnEmpty()
            : MainListCard(ourList, firstUser));
  }
}
