import 'package:flutter/material.dart';

import './list_lists.dart';
import '../widgets/home_fab.dart';
import '../scoped-models/main_model.dart';

class MyHomePage extends StatelessWidget {
  final String title = 'Lists';
  final MainModel _listModel;

  MyHomePage(this._listModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListLists(_listModel),
      floatingActionButton: HomeFab(),
    );
  }
}
