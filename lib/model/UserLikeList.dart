import 'dart:io';
import 'Users.dart';

class UserLikeList {
  String? phoneNo;
  UserLikeList({this.phoneNo});


  static UserLikeList fromMap(Map<String, dynamic> map) {
    return UserLikeList(
      phoneNo: map['phoneNo'],
    );
  }
}