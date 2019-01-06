import 'package:flutter/material.dart';

import '../ui_elements/main_list_card.dart';
import '../models/list_model.dart';
import '../models/user.dart';

class ListLists extends StatelessWidget {
  final List<ListModel> ourList;
  final UserModel firstUser;
  ListLists(this.ourList, this.firstUser);

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
        child:
            ourList == null ? returnEmpty() : MainListCard(ourList, firstUser));
  }
}
