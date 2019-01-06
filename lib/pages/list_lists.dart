import 'package:flutter/material.dart';

import '../ui_elements/main_list_card.dart';
import '../models/list_model.dart';

class ListLists extends StatelessWidget {
  final List<ListModel> ourList;

  ListLists(this.ourList);

  Widget returnEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('No list currently created.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ourList == null ? returnEmpty() : MainListCard(ourList));
  }
}
