import 'package:flutter/material.dart';

import '../ui_elements/main_list_card.dart';

class ListLists extends StatelessWidget {
  final List ourList = [
    {
      'title': 'My first list',
      'creator': 'Rider',
      'permissions': 'full',
      'items': {
        'incomplete': [
          'Here is an undone item',
          'here is the second undone item',
          'here is the thrid undone item'
        ],
        'complete': [
          {
            'item': 'here is the first item',
            'date': 'date here',
            'userCom': 'Rider'
          },
          {
            'item': 'here is the second item',
            'date': 'date here',
            'userCom': 'Rider'
          },
          {
            'item': 'here is the third item',
            'date': 'date here',
            'userCom': 'Rider'
          }
        ]
      }
    }
  ];

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
