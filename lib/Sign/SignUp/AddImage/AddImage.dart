// import 'package:appdatting/InforPage/InforItem/Information/AddImage/ImageGrid.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:appdatting/model/UserImage.dart';
import 'package:appdatting/model/Users.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:path_provider/path_provider.dart';



class AddImage extends StatefulWidget{

int? index;
Users? users;
UserImages? imageList;

AddImage({this.index,this.users,this.imageList});




  @override
  State<StatefulWidget> createState() => AddImageState(index : index,users:users,images: imageList);
}

class AddImageState extends State<AddImage> {
  int? index;
  Users? users;
  UserImages? images;
  AddImageState({this.index,this.users,this.images});

  List<UserImages?> imagesList = UserImages.listImage;
  // File imageFile =  ;
  File? imageFile = null;

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return  DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8),
          child: imageFile == null ? imageFalse() :  imageTrue(),



      //   onTap: () async {
      // imageItem!.imageFile == null ? _getFromGallery() : _asyncConfirmDialog(context);
      //  },
    );

  }

  Widget imageTrue(){
    // print(users!.listImages!)
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
              child: Image.file(imageFile!,fit: BoxFit.fill ,)
          ),

        ),
    );


  }

  Widget imageFalse(){

    return GestureDetector(
      onTap: (){
        _getFromGallery();
      },
        child:Container(
          alignment: Alignment.bottomRight,
          decoration:
          BoxDecoration(
              color: Color.fromARGB(50, 124, 120, 120)
          ),
          width: double.infinity,
          height: double.infinity,


        )
    );

  }
  void addImageUser (int index){
    imagesList[index]=UserImages(imageFile: File(imageUrl));
  }
  void removeImageUser (int index) {
    imagesList.remove(imagesList[index]);
  }
  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String uniqueFileName =
      DateTime.now().millisecondsSinceEpoch.toString();
      imageFile = File(pickedFile.path);

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      //Create a reference for the image to be stored
      Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
      try {
        //Store the file
        print(imageFile);
        await referenceImageToUpload.putFile(imageFile!);

        //Success: get the download URL
        imageUrl = await referenceImageToUpload.getDownloadURL();
        print(imageUrl);

      } catch (error) {
        //Some error occurred
      }

      setState(() {
        addImageUser(index!);
        print(imagesList);
      });
    }
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
                    // print(imagesList);
                    Navigator.of(context).pop();
                  });
                },
              ),
            ]
        );
      },
    );
  }

}