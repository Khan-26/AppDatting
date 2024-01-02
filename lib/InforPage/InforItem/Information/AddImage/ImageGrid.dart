

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ItemImage.dart';

import '../../../../model/UserImage.dart';
import 'package:appdatting/model/Users.dart';


import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImageGrid extends StatefulWidget{
  Users? users;

  ImageGrid({this.users});

  @override
  State<StatefulWidget> createState() => ImageGridState(users: users);
}

class ImageGridState extends State<ImageGrid>{
  ImageGridState({this.users});
  Users? users;
  UserImages? imageList = UserImages();
  String imageUrl = '';
  File? imageFile = null;

  // List<UserImages?> listImage = UserImages.listImage ;
  CollectionReference user = FirebaseFirestore.instance.collection('Users');
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
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      String uniqueFileName =
      DateTime.now().millisecondsSinceEpoch.toString();


      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      //Create a reference for the image to be stored
      Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
      try {
        //Store the file
        // print(imageFile);
        await referenceImageToUpload.putFile(imageFile!);

        //Success: get the download URL
        imageUrl = await referenceImageToUpload.getDownloadURL();
        print(imageUrl);

      } catch (error) {
        //Some error occurred
      }
      UserImages img = UserImages(imageFile: File(imageUrl));

      setState(() {
        users!.listImages!.add(img);
        user.doc(users!.phoneNo).update({
          'listImage':listAddImage(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context){

    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child:  Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.topRight,
              child:GestureDetector(
                onTap: (){
                  _getFromGallery();
                },
                child: Text('Thêm ảnh',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),),
              )
          ),
          GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              // itemCount: listImage!.length,
              itemCount: users!.listImages!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context,index) {
                return ItemImage(
                  users: users,
                  index : index,
                  imageList: users!.listImages![index],

                );
              }

          ),
        ],



      ),
    );


  }


}
// class ImageItem extends StatelessWidget {
//   int? id;
//   UserImages? imageList;
//   // List? list;
//
//   ImageItem({this.id,this.imageList});
//
//
//
//   @override
//   Widget build(BuildContext context){
//
//     return AddImage();
//   }
// }




