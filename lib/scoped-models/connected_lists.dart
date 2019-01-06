import 'package:scoped_model/scoped_model.dart';

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

  void addToUserLists(ListModel incomingListAddition) {
    _userLists.add(incomingListAddition);
  }

  void selectAListCode(String code) {
    _selectedListCode = code;
  }

  void setUserLists() {
    // query db for each firstUser.lists
    _authenticatedUser.lists.forEach((listId) {
      _userLists
          .add(ourList[ourList.indexWhere((item) => item.shareId == listId)]);
    });
  }

  void removeAList(String incShareId) {
    _userLists.removeWhere((item) => item.shareId == incShareId);
  }

  void addANewList(String code) {
    _authenticatedUser.lists.add(code);
  }

  void signIn(String username, String password) {
    // check the user against the DB
    _authenticatedUser = new UserModel(
      username: username,
      email: 'riderjensen@gmail.com',
      lists: ['c750f160', 'cba0c380'],
    );
  }

  void signUp(String username, String email, String password) {
    // put in db
    _authenticatedUser = new UserModel(
      username: username,
      email: email,
      lists: ['c750f160', 'cba0c380'],
    );
  }
}
