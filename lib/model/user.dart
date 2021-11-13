import 'package:flutter/cupertino.dart';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? profession;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.profession
  });
}