import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../local_keys.dart';

import '../models/list_model.dart';
import '../models/user.dart';
import '../resources/dummyData.dart';

mixin ConnectedLists on Model {
  List<ListModel> _userLists = [];
  UserModel _authenticatedUser;
  String _selectedListCode;
}

mixin GetListInformation on ConnectedLists {
  List<ListModel> get userLists {
    return _userLists;
  }

  UserModel get authUser {
    return _authenticatedUser;
  }

  String get selectedItem {
    return _selectedListCode;
  }

  ListModel get getOneList {
    return _userLists[
        _userLists.indexWhere((item) => item.shareId == _selectedListCode)];
  }

  Future addToUserLists(ListModel incomingListAddition) async {
    final Map<String, dynamic> myAddData = {
      'id': incomingListAddition.id,
      'shareId': incomingListAddition.shareId,
      'title': incomingListAddition.title,
      'icon': incomingListAddition.icon,
      'creator': incomingListAddition.creator,
      'fullPermissions': incomingListAddition.fullPermissions,
      'items': [],
      'toggleDelete': false
    };
    http
        .post('https://lean-list.firebaseio.com/lists.json',
            body: json.encode(myAddData))
        .then((_) {
      _userLists.add(incomingListAddition);
    });
  }

  void selectAListCode(String code) {
    _selectedListCode = code;
  }

  void setUserLists() {
    _authenticatedUser.lists.forEach((listId) {
      _userLists
          .add(ourList[ourList.indexWhere((item) => item.shareId == listId)]);
    });
  }

  void removeAList(String incShareId) {
    _userLists.removeWhere((item) => item.shareId == incShareId);
  }

  void addANewList(String code) async {
    _authenticatedUser.lists.add(code);
    //push new item to list in the DB
    final http.Response addNewList =
        await http.post('https://lean-list.firebaseio.com/users.json');
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final http.Response userResponse = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${firebaseKey}',
      body: jsonEncode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> theUserResponseDecoded =
        jsonDecode(userResponse.body);

    if (theUserResponseDecoded.containsKey('error')) {
      return {
        'success': false,
        'message': theUserResponseDecoded['error']['message']
      };
    } else {
      final http.Response fullUsersResponse =
          await http.get('https://lean-list.firebaseio.com/users.json');

      final Map<String, dynamic> allUsers = json.decode(fullUsersResponse.body);
      allUsers.forEach((String id, dynamic listData) {
        if (email == listData['email']) {
          _authenticatedUser = new UserModel(
            firebaseId: listData['localId'],
            username: listData['username'],
            email: listData['email'],
            lists: listData['lists'] == null ? [] : listData['lists'],
          );
        } else {
          print('Something went terribly wrong with the DB');
        }
      });
      setUserLists();
      return {'success': true};
    }
  }

  Future<Map<String, dynamic>> signUp(
      String username, String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${firebaseKey}',
      body: jsonEncode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> theResponseDecoded = jsonDecode(response.body);

    if (theResponseDecoded.containsKey('error')) {
      return {
        'success': false,
        'message': theResponseDecoded['error']['message']
      };
    } else {
      final Map<String, dynamic> myAddUser = {
        'username': username,
        'email': email,
        'lists': []
      };
      final http.Response secondResponse = await http.post(
          'https://lean-list.firebaseio.com/users.json',
          body: json.encode(myAddUser));
      final Map<String, dynamic> secondResponseDecoded =
          jsonDecode(secondResponse.body);
      if (secondResponseDecoded.containsKey('error')) {
        return {
          'success': false,
          'message': theResponseDecoded['error']['message']
        };
      } else {
        _authenticatedUser = new UserModel(
          firebaseId: theResponseDecoded['localId'],
          username: username,
          email: email,
          lists: [],
        );
        setUserLists();
        return {'success': true};
      }
    }
  }
}
