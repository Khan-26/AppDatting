// import 'package:appdatting/InforPage/InforItem/Information/AddImage/ImageGrid.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:appdatting/model/UserImage.dart';
import 'package:appdatting/model/Users.dart';

import 'package:dotted_border/dotted_border.dart';



class ItemImage extends StatefulWidget{
Users? users;
int? index;
  // List? list;
UserImages? imageList;

ItemImage({this.users,this.index,required this.imageList});




  @override
  State<StatefulWidget> createState() => ItemImageState(index : index,users: users,images: imageList);
}

class ItemImageState extends State<ItemImage> {
  int? index;
  Users? users;
  UserImages? images;
  ItemImageState({this.index,this.users,this.images});

  CollectionReference user = FirebaseFirestore.instance.collection('Users');

  // List<UserImages?> imagesList = UserImages.listImage;

  bool state = false;
  // File? imageFile = null;


  @override
  Widget build(BuildContext context) {
    print(images);
    // print(images!.imageFile);
    // print(File(images!.imageFile!.toString().substring(8,79)));
    return  DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8),
          child: imageTrue(),



      //   onTap: () async {
      // imageItem!.imageFile == null ? _getFromGallery() : _asyncConfirmDialog(context);
      //  },
    );

  }

  Widget imageTrue(){
    // print(images!.imageFile!);
    return GestureDetector(
      onTap: (){
        _asyncConfirmDialog(context);
      },
        child:Container(

          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(8),

          ),
          child:ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(images!.imageFile!.path,fit: BoxFit.fill ,)
          ),

        ),
    );


  }

  List listAddImage(){
    List imageList = [];
    for (UserImages? userImage in users!.listImages!) {
      if (userImage != null) {
        // Add the non-null item to Cloud Firestore
        imageList.add({"filename": userImage.imageFile!.path});
      }
      // print(userImage!.imageFile.toString().substring(8,80));
    }
    return imageList;
  }

  void removeImageUser (int index) {
      setState(() {
        users!.listImages!.remove(users!.listImages![index]);
        user.doc(users!.phoneNo).update({
          'listImage':listAddImage(),
        });
      });


  }

  _asyncConfirmDialog(BuildContext context) async {
    return  showDialog (
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Xóa hình ảnh này?'),

            actions: <Widget>[
              TextButton(
                child: const Text("Hủy"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Xóa',style:TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
                onPressed: () {
                  setState(() {
                    removeImageUser(index!);
                     Navigator.of(context).pop(users);
                  });
                },
              ),
            ]
        );
      },
    );
  }

}