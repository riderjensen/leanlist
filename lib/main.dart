import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped-models/main_model.dart';
import './pages/my_home_page.dart';
import './pages/list_one_list.dart';
import './pages/create_new_list.dart';
import './pages/auth.dart';
import './pages/sign_up.dart';
import './pages/loading_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _listModel = MainModel();
  bool checkAuth = false;

  @override
  void initState() {
    _listModel.autoAuthenticate().then((response) {
      if (response == null ||
          _listModel.authUser == null ||
          response['success'] == false) {
        setState(() {
          checkAuth = true;
        });
        return;
      }
      if (_listModel.authUser != null) {
        _listModel.setUserLists().then((_) {
          setState(() {
            checkAuth = true;
          });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (checkAuth) {
      return ScopedModel<MainModel>(
        model: _listModel,
        child: MaterialApp(
          title: 'Lean List',
          theme: ThemeData(
              primarySwatch: Colors.brown,
              brightness: Brightness.light,
              accentColor: Colors.green),
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
                builder: (BuildContext context) => ListOneList(_listModel),
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
    } else {
      return MaterialApp(
        title: 'Test',
        home: LoadingPage(),
      );
    }
  }
}
