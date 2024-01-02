import 'package:appdatting/model/UserImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';

import '../AddImage/ImageGrid.dart';
// import '../../../InforPage/InforItem/Information/AddImage/ImageGrid.dart';
import 'package:appdatting/model/Users.dart';

import 'FormAddLike.dart';

class FormAddImg extends StatefulWidget{

  Users? users;
  FormAddImg({this.users});

  @override
  State<StatefulWidget> createState() => FormAddImgState(users :users);

}

class FormAddImgState extends State<FormAddImg> {
  UserImages? userImages;
  Users? users;
  FormAddImgState({this.users});
  void addImage(UserImages e){
    users!.listImages!.add(e);
  }

  @override
  Widget build(BuildContext context){
    users!.listImages = [];
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Thêm hình ảnh ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),


      ),
      body: Container(

          child:  Column(

            children: [
              //Hàng 1

              ImageGrid(users: users,),


              //Hàng 3
              Container(
                // margin: EdgeInsets.only(top: 30),
                child: button(),
              )
            ],
          )
      )
    );
  }


  Widget button(){
    return Container(

      margin:EdgeInsets.only(top:30),
      decoration:BoxDecoration(

        border:Border.all(width:1.0,color:Colors.black),
        borderRadius:BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () => {
          // print(users!.listImages!),
          // users!.listImages = UserImages.listImage,
          UserImages.listImage.map((e){

            if(e != null){
              users!.listImages!.add(e);
            }

          }).toList(),
          // UserImages.listImage.map((e) {
          //   if(e != null){
          //     // addImage(UserImages(imageFile: e.imageFile));
          //     users!.listImages.add(UserImages(imageFile: e.imageFile));
          //   }
          // }).toList(),

          print(users!.listImages),
          Navigator.of(context).push(_SignUpRoute(FormAddLike(users: users))),
        },
        child: Text('Chuyển tiếp',style:TextStyle(color:Colors.redAccent)),
      ),
    );
  }

}

Route _SignUpRoute (route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}