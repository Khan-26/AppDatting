import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';

class UserImages{
  int? id;
  File? imageFile ;


  UserImages({this.id,this.imageFile});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'filename': imageFile,
  //   };
  // }

 static List<UserImages?> listImage = [null,null,null,null,null,null];

 void changeImage(){

 }

  static UserImages fromMap(Map<String, dynamic> map) {
   // print(File(map['filename']));
    return UserImages(
      imageFile:File(map['filename']),
    );
  }

}