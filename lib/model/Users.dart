import 'dart:developer';

import 'dart:io';
import 'package:appdatting/Sign/SignUp/Form/FormAddLike.dart';
import 'package:appdatting/model/UserListChat.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '../../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserImage.dart';
import 'UserHobbies.dart';
import 'UserLikeList.dart';
import 'UserListChat.dart';
import '../Sign/SignUp/Form/FormAddLike.dart';


class Users{



  String? id;
  String? phoneNo;
  String? name;
  String? age;
  String? sex;
  String? description;
  String? email;
  List<UserImages?>? listImages = UserImages.listImage;
  List<UserHobbies>? listHobbies = [];
  List<UserLikeList>? userLikeList = [];
  List<UserListChat>? userListChat = [];


  Users({this.id,this.phoneNo,this.name,this.age,this.sex,this.description,this.email,this.listImages,this.listHobbies,this.userLikeList,this.userListChat});

  CollectionReference user = FirebaseFirestore.instance.collection('Users');
  // Future<String> catchDocId(documentID)async{
  //
  //   var querySnapshots = await user.get();
  //   for (var snapshot in querySnapshots.docs) {
  //     documentID = snapshot.id; // <-- Document ID
  //   }
  //   return Future.delayed(Duration(seconds: 10),()=>documentID);
  // }
 Future<void> addUsers() async{

   var documentID;
    // var docID = catchDocId(documentID);

    print(UserImages.listImage);
    print(this.listHobbies);
    return user.doc(this.phoneNo)
        .set({
      'phoneNo': this.phoneNo,
      'name': name,
      'age': age,
      'sex':sex,
      'description':description,
      'email':email,
      'listImage': listAddImage(),
      'listHobbies': listAddHobbies(),
      'listUserLike':userLikeList,
      'listUserChat':userListChat,

    })
        .then((value) => print("User Added"))
        .catchError((error) =>  print("Failed to add user: $error"));
  }



  static Future<Users?> getUserById(String id) async {
    DocumentReference<Map<String, dynamic>> docRef =
    FirebaseFirestore.instance.collection('Users').doc(id);

    DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();

    if (doc.exists) {
      return Users(
        id: doc.id,
        phoneNo: doc['phoneNo'],
        name: doc['name'],
        age: doc['age'],
        sex: doc['sex'],
        description: doc['description'],
        email: doc['email'],
        listImages: List<UserImages?>.from(doc['listImage'].map((imageMap) => UserImages.fromMap(imageMap)).toList()),
        listHobbies: List<UserHobbies>.from(doc['listHobbies'].map((hobbiesMap) => UserHobbies.fromMap(hobbiesMap)).toList()),
        
        userLikeList: doc['listUserLike'] == null ? [] : List<UserLikeList>.from(doc['listUserLike'].map((userLikeMap) => UserLikeList.fromMap(userLikeMap)).toList()),
        userListChat:doc['listUserChat'] == null ? [] : List<UserListChat>.from(doc['listUserChat'].map((userLikeMap) => UserListChat.fromMap(userLikeMap)).toList()),
      );
    } else {
      return null;
    }
  }



  List listAddImage(){
    List imageList = [];
    for (UserImages? userImage in UserImages.listImage) {
      if (userImage != null) {
        // Add the non-null item to Cloud Firestore
        imageList.add({"filename": userImage.imageFile!.path});
      }
      // print(userImage!.imageFile.toString().substring(8,80));
    }
    return imageList;
  }
  List listAddHobbies(){
    List hoList = [];

    for (UserHobbies? userHobbies in listHobbies!) {
      if (userHobbies != null) {
        // Add the non-null item to Cloud Firestore
        hoList.add({"hobbies": userHobbies.hobbies});
      }
    }
    return hoList;
  }


  //hàm add vào list chat
  // void addListChat(User? user_sec, User? user_op){
  //
  //   if(user_op!.phoneNo ==  && user_sec.phoneNo == (user_op!.userLikeList)!.phoneNo){
  //     (user_sec!.userListChat)!.add(user_op);
  //     (user_op!.userListChat)!.add(user_sec);
  //   }
  // }




}






