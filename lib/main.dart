import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped-models/main_model.dart';
import './pages/my_home_page.dart';
import './pages/list_one_list.dart';
import './pages/create_new_list.dart';
import './pages/auth.dart';
import './pages/sign_up.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _listModel = MainModel();

  @override
  void initState() {
    //TODO
    //Get user information that is stored on the phone and set the auth user
    if (_listModel.authUser != null) {
      _listModel.setUserLists();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _listModel,
      child: MaterialApp(
        title: 'Lean List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _listModel.authUser == null
            ? AuthPage(_listModel)
            : MyHomePage(_listModel),
        routes: {
          '/auth': (BuildContext context) => AuthPage(_listModel),
          '/sign_up': (BuildContext context) => SignUp(_listModel),
          '/lists': (BuildContext context) => MyHomePage(_listModel),
          '/create': (BuildContext context) => CreateNewList(_listModel)
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'list') {
            final String listId = pathElements[2];
            _listModel.selectAListCode(listId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ListOneList(
                  _listModel.getOneList, _listModel.authUser.username),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(_listModel));
        },
      ),
    );
  }
}
