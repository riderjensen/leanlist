import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    if (_userLists.isEmpty) {
      print('user list is null');
      return null;
    }
    final ListModel myReturnModel = _userLists[
        _userLists.indexWhere((item) => item.firebaseId == _selectedListCode)];

    if (myReturnModel.items == null) {
      myReturnModel.setItems({'incomplete': [], 'complete': []});
    }
    return myReturnModel;
  }

  Future<void> addToUserLists(ListModel incomingListAddition) async {
    final Map<String, dynamic> myAddData = {
      'title': incomingListAddition.title,
      'icon': incomingListAddition.icon,
      'creator': incomingListAddition.creator,
      'fullPermissions': incomingListAddition.fullPermissions,
      'items': {'incomplete': [], 'complete': []},
      'toggleDelete': false,
      'firebaseId': null
    };
    return await http
        .post('https://lean-list.firebaseio.com/lists.json',
            body: json.encode(myAddData))
        .then((response) {
      final Map<String, dynamic> returnedData = jsonDecode(response.body);
      incomingListAddition.firebaseId = returnedData['name'];
      _userLists.add(incomingListAddition);
      _authenticatedUser.lists.add(returnedData['name']);
      selectAListCode(returnedData['name']);
      return updateUserInDB().then((_) {
        return updateListInDB();
      });
    });
  }

  void clearCurrentLists() {
    _authenticatedUser.lists.clear();
  }

  Future<void> updateUserInDB() async {
    final Map<String, dynamic> updatedUser = {
      'email': _authenticatedUser.email,
      'username': _authenticatedUser.username,
      'lists': _authenticatedUser.lists
    };

    return await http.put(
        'https://lean-list.firebaseio.com/users/' +
            _authenticatedUser.firebaseId +
            '.json',
        body: jsonEncode(updatedUser));
  }

  Future<void> updateListInDB() async {
    final ListModel myList = getOneList;

    final Map<String, dynamic> outgoingList = {
      'title': myList.title,
      'icon': myList.icon,
      'creator': myList.creator,
      'fullPermissions': myList.fullPermissions,
      'items': myList.items,
      'toggleDelete': myList.toggleDelete,
      'firebaseId': myList.firebaseId
    };
    print('--update called--');
    return await http.put(
        'https://lean-list.firebaseio.com/lists/' +
            outgoingList['firebaseId'] +
            '.json',
        body: jsonEncode(outgoingList));
  }

  void selectAListCode(String code) {
    _selectedListCode = code;
  }

  Future<void> setUserLists() async {
    List<Future> myFutures = [];
    _authenticatedUser.lists.forEach((listId) {
      myFutures.add(
          http.get('https://lean-list.firebaseio.com/lists/${listId}.json'));
    });

    List returnedList = await Future.wait(myFutures);

    returnedList.forEach((item) {
      final Map<String, dynamic> returnedData = jsonDecode(item.body);
      if (returnedData != null) {
        final ListModel myAddition = new ListModel(
            title: returnedData['title'],
            toggleDelete: returnedData['toggleDelete'],
            creator: returnedData['creator'],
            fullPermissions: returnedData['fullPermissions'],
            icon: returnedData['icon'],
            firebaseId: returnedData['firebaseId'],
            items: returnedData['items']);
        _userLists.add(myAddition);
      } else {
        print('We couldnt find this list in the DB');
      }
    });
  }

  void removeAList(String firebaseId) {
    _userLists.removeWhere((item) => item.firebaseId == firebaseId);
    _authenticatedUser.lists.removeWhere((item) => item == firebaseId);
    // http.delete(
    //     'https://lean-list.firebaseio.com/lists/' + firebaseId + '.json');
    updateUserInDB();
  }

  Future<Map<String, dynamic>> signIn(String email, String password) {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    return http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${firebaseKey}',
      body: jsonEncode(authData),
      headers: {'Content-Type': 'application/json'},
    ).then((userResponse) {
      final Map<String, dynamic> theUserResponseDecoded =
          jsonDecode(userResponse.body);

      if (theUserResponseDecoded.containsKey('error')) {
        return {
          'success': false,
          'message': theUserResponseDecoded['error']['message']
        };
      } else {
        return http
            .get('https://lean-list.firebaseio.com/users.json')
            .then((fullUsersResponse) {
          final Map<String, dynamic> allUsers =
              json.decode(fullUsersResponse.body);
          allUsers.forEach((String id, dynamic listData) {
            if (email == listData['email']) {
              _authenticatedUser = new UserModel(
                firebaseId: id,
                username: listData['username'],
                email: listData['email'],
                lists: listData['lists'] == null ? [] : listData['lists'],
              );
              SharedPreferences.getInstance().then((prefs) {
                prefs.setString('userEmail', listData['email']);
                prefs.setString('username', listData['username']);
              });
            }
          });
          return setUserLists().then((_) {
            return {'success': true};
          });
        });
      }
    });
  }

  Future<Map<String, bool>> autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('userEmail');
    final String username = prefs.getString('username');
    if (userEmail != null && username != null) {
      return http
          .get('https://lean-list.firebaseio.com/users.json')
          .then((fullUsersResponse) {
        final Map<String, dynamic> allUsers =
            json.decode(fullUsersResponse.body);
        allUsers.forEach((String id, dynamic listData) {
          if (userEmail == listData['email']) {
            _authenticatedUser = new UserModel(
              firebaseId: id,
              username: listData['username'],
              email: listData['email'],
              lists: listData['lists'] == null ? [] : listData['lists'],
            );
          }
        });
        return setUserLists().then((_) {
          return {'success': true};
        });
      });
    } else {
      return _authenticatedUser = null;
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
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('userEmail', email);
          prefs.setString('username', username);
        });
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
