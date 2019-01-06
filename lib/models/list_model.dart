import 'package:flutter/material.dart';

class ListModel {
  final String id;
  final String shareId;
  final String title;
  final int icon;
  final String creator;
  final bool fullPermissions;
  bool toggleDelete;
  final Map<String, List> items;

  ListModel({
    @required this.id,
    @required this.shareId,
    @required this.title,
    @required this.icon,
    @required this.creator,
    @required this.fullPermissions,
    @required this.toggleDelete,
    @required this.items,
  });
}
