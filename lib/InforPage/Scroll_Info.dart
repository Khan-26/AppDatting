import 'package:appdatting/model/UserImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'InforItem/Image_Info.dart';
import 'InforItem/Information/AddImage/ImageGrid.dart';

import 'InforItem/Information/Your_Info/About_Your.dart';
import 'package:appdatting/model/Users.dart';

class Scroll_Info extends StatefulWidget{
  Users? users;
  Scroll_Info({super.key,this.users});

  @override
  State<StatefulWidget> createState() => Scroll_InfoState(users:users);
}

class Scroll_InfoState extends State<Scroll_Info>{
  Users? users;
  Scroll_InfoState({this.users});
  UserImages? images;

  @override
  Widget build(BuildContext context){
    return Column(

      // hinhf anh ten tuoi
      children:[
        Container(
          height: 250,
          padding: EdgeInsets.only(top: 30),
          child: Image_Info(users: users),
          decoration: BoxDecoration(color: Colors.white),
        ),

        // danh sach hinh anh
        Container(

          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:20,left: 25,right: 25),

                      alignment: Alignment.topLeft,
                      child: Text(

                        'ẢNH',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      ),
                    ),

              //hien thi danh sach hinh anh
              Container(

                child: ImageGrid(users:users),
              ),
            ],
          ),
        ),
        //
        // GIỚI THIỆU BẢN THÂN
        //

        Container(
          child: About_Your(users:users),
        )


            ],
          );
    }
}
/// Get from gallery
