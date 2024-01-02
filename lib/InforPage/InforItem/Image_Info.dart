


import 'dart:convert';
import 'dart:io';

import 'package:appdatting/model/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:appdatting/model/UserImage.dart';
// DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('Users').doc(documentID);
class Image_Info extends StatefulWidget{

  Users? users;

  Image_Info({super.key,this.users});

  // static getUserData(phoneNo) async{
  //   try {
  //     late DocumentReference<Map<String, dynamic>> auth = FirebaseFirestore.instance.collection('Users').doc(phoneNo);
  //     DocumentSnapshot<Map<String, dynamic>> doc = await auth.get();
  //     if (doc.exists) {
  //       return doc.data();
  //     } else {
  //       print("No such document!");
  //       return null;
  //     }
  //   } catch (error) {
  //     print("Error getting document: +${error}");
  //     return null;
  //   }
  // }

  @override
  State<Image_Info> createState() => _Image_InfoState(users:users);
}

class _Image_InfoState extends State<Image_Info> {
  List<UserImages?>? list = [];
  File? images ;
  Users? users;
  _Image_InfoState({this.users});
  late DocumentReference<Map<String, dynamic>> auth = FirebaseFirestore.instance.collection('Users').doc(users!.phoneNo);

  // File getImageUser() async {
  // @override
  // void initState() async {
  //   super.initState();
  //   DocumentSnapshot<Map<String, dynamic>> doc = await auth.get();
  //   // perform initialization here
  //   list = List<UserImages?>.from(doc['listImage'].map((imageMap) => UserImages.fromMap(imageMap)).toList());
  //   images=list!.first!.imageFile;
  //
  // }

  @override
  Widget build(BuildContext context){
    // print(users!.listImages!.first!.imageFile);
    // print(users!.listImages!.first!.imageFile.toString().substring(0,6));
    // print(File(users!.listImages!.first!.imageFile.toString().substring(8,79)));
    // File a = users!.listImages!.first!.imageFile.toString().substring(5) as File;
    // print(a);
    print(users!.listImages!.first!.imageFile!.path);
    return Column(
      children:[
        Container(
          alignment: Alignment.center,
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(users!.listImages!.first!.imageFile!.path,width: 100,),
            // child: const Image(image: AssetImage('./assets/images/img.png'),width: 170,),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            '${widget.users!.name}, ${widget.users!.age}' ,
            // '${users!.listImages!.first!.imageFile}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        ),
      ]
    );
  }
}