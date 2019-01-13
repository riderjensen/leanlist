import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:flutter/material.dart';

import '../form_elements/add_list_dialog.dart';
import '../scoped-models/main_model.dart';

class HomeFab extends StatefulWidget {
  final MainModel myModel;

  HomeFab(this.myModel);

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
        return AddListDialog(widget.myModel);
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
          Theme.of(context).accentColor,
          4.0,
          "Button menu",
          _addNewListToAccount,
          "Enter an old code",
          Theme.of(context).accentColor,
          Colors.white,
          true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.add),
          Theme.of(context).accentColor,
          4.0,
          "Button menu",
          _sendToCreatePage,
          "Create a new list",
          Theme.of(context).accentColor,
          Colors.white,
          true),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new FabDialer(
          _fabMiniMenuItemList,
          Theme.of(context).accentColor,
          new Icon(Icons.add),
        ),
      ],
    );
  }
}
