import 'package:scoped_model/scoped_model.dart';
import '../models/list_model.dart';
import '../models/user.dart';
import '../resources/dummyUser.dart';
import '../resources/dummyData.dart';

mixin ConnectedLists on Model {
  List<ListModel> _userLists = [];
  UserModel _authenticatedUser;
  String _selectedListNumber;
}

mixin GetListInformation on ConnectedLists {
  List<ListModel> get userLists {
    // query db for each firstUser.lists
    firstUser.lists.forEach((listId) {
      _userLists
          .add(ourList[ourList.indexWhere((item) => item.shareId == listId)]);
    });
    return _userLists;
  }

  UserModel get authUser {
    return _authenticatedUser;
  }

  String get selectedItem {
    return _selectedListNumber;
  }
}
