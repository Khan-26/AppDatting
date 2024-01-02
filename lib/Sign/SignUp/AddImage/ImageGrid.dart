

import 'package:appdatting/InforPage/InforItem/Information/Your_Info/Popup/Popup_Like.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'AddImage.dart';

import '../../../../model/UserImage.dart';
import 'package:appdatting/model/Users.dart';

class ImageGrid extends StatefulWidget{
  Users? users;

  ImageGrid({this.users});

  @override
  State<StatefulWidget> createState() => ImageGridState(users: users);
}

class ImageGridState extends State<ImageGrid> {
  ImageGridState({this.users});

  Users? users;
  UserImages? imageList;
  final List<UserImages?> listImage = UserImages.listImage;




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),


          child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              // itemCount: listImage!.length,
              itemCount: listImage!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return AddImage(
                  index: index,
                  imageList: listImage[index],

                );
              }

          ),
        )
      ],
    );
  }


}




