import 'package:flutter/material.dart';

import './resources/dummyData.dart';
import './resources/dummyUser.dart';
import './models/list_model.dart';
import './widgets/home_fab.dart';
import './pages/list_lists.dart';
import './pages/list_one_list.dart';
import './pages/create_new_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lean List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {'/create': (BuildContext context) => CreateNewList(ourList)},
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'list') {
          final String listId = pathElements[2];
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ListOneList(listId),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage());
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title = 'Lists';
  List<ListModel> myNewestList = [];

  @override
  Widget build(BuildContext context) {
    firstUser.lists.forEach((listId) {
      myNewestList
          .add(ourList[ourList.indexWhere((item) => item.shareId == listId)]);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListLists(myNewestList),
      floatingActionButton: HomeFab(),
    );
  }
}
