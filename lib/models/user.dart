import 'package:flutter/material.dart';

class UserModel {
  final String firebaseId;
  final String username;
  final String email;
  final List lists;

  UserModel({
    @required this.firebaseId,
    @required this.username,
    @required this.email,
    @required this.lists,
  });
}
