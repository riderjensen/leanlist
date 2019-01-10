import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../local_keys.dart';

import '../models/list_model.dart';
import '../models/user.dart';

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
    _userLists.add(incomingListAddition);
    http
        .post('https://lean-list.firebaseio.com/lists.json',
            body: json.encode(myAddData))
        .then((response) {
      final Map<String, dynamic> returnedData = jsonDecode(response.body);
      _authenticatedUser.lists.add(returnedData['name']);
      updateUserInDB();
    });
  }

  void updateUserInDB() {
    final Map<String, dynamic> updatedUser = {
      'email': _authenticatedUser.email,
      'username': _authenticatedUser.username,
      'lists': _authenticatedUser.lists
    };

    http.put(
        'https://lean-list.firebaseio.com/users/' +
            _authenticatedUser.firebaseId +
            '.json',
        body: jsonEncode(updatedUser));
  }

  void selectAListCode(String code) {
    _selectedListCode = code;
  }

  Future<bool> setUserLists() {
    print('calling set user list');
    _authenticatedUser.lists.forEach((listId) async {
      final myResp = await http
          .get('https://lean-list.firebaseio.com/lists/' + listId + '.json');
      final Map<String, dynamic> returnedData = jsonDecode(myResp.body);
      if (returnedData != null) {
        final ListModel myAddition = new ListModel(
            id: returnedData['id'],
            title: returnedData['title'],
            toggleDelete: returnedData['toggleDelete'],
            creator: returnedData['creator'],
            fullPermissions: returnedData['fullPermissions'],
            icon: returnedData['icon'],
            shareId: returnedData['shareId'],
            items: returnedData['items']);
        print('adding to list');
        _userLists.add(myAddition);
      }
    });
    return Future(() {
      print('calling end future');
      return true;
    });
  }

  void removeAList(String incShareId) {
    _userLists.removeWhere((item) => item.shareId == incShareId);
    _authenticatedUser.lists.removeWhere((item) => item.shareId == incShareId);
    updateUserInDB();
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
            firebaseId: id,
            username: listData['username'],
            email: listData['email'],
            lists: listData['lists'] == null ? [] : listData['lists'],
          );
        }
      });
      print('before set user list');
      await setUserLists();
      print('after set user list');
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
          firebaseId: secondResponseDecoded['name'],
          username: username,
          email: email,
          lists: [],
        );
        return {
          'success': true,
        };
      }
    }
  }
}
