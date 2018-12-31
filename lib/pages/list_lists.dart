import 'package:flutter/material.dart';

class ListLists extends StatelessWidget {
  final Map<String, dynamic> ourList = {
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
  };
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text('No list currently created.'),
            ],
          )
        ],
      ),
    );
  }
}
