import 'dart:io';
import 'Users.dart';

class UserListChat{

  String? phoneNo;

  UserListChat({this.phoneNo});

  List<UserListChat>? data;

  static UserListChat fromMap(Map<String, dynamic> map) {
    return UserListChat(
     phoneNo: map['phoneNo']
    );
  }



}