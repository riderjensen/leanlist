import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:flutter/material.dart';

import '../form_elements/add_list_dialog.dart';

class HomeFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeFab();
  }
}

class _HomeFab extends State<HomeFab> with TickerProviderStateMixin {
  Future _addNewListToAccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddListDialog();
      },
    );
  }

  void _sendToCreatePage() {
    Navigator.of(context).pushNamed('/create');
  }

  @override
  Widget build(BuildContext context) {
    final List<FabMiniMenuItem> _fabMiniMenuItemList = [
      new FabMiniMenuItem.withText(
          new Icon(Icons.add),
          Colors.blue,
          4.0,
          "Button menu",
          _addNewListToAccount,
          "Enter an old code",
          Colors.blue,
          Colors.white,
          true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.add),
          Colors.blue,
          4.0,
          "Button menu",
          _sendToCreatePage,
          "Create a new list",
          Colors.blue,
          Colors.white,
          true),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new FabDialer(
          _fabMiniMenuItemList,
          Colors.blue,
          new Icon(Icons.add),
        ),
      ],
    );
  }
}
