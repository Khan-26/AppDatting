import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appdatting/model/Users.dart';
import '../../../../InforPage.dart';
class PopDescrip extends StatefulWidget {
  Users? users;
  PopDescrip({this.users});

  @override
  State<PopDescrip> createState() => _PopDescripState(users:users);
}

class _PopDescripState extends State<PopDescrip> {
  Users? users;
  _PopDescripState({this.users});
  late DocumentReference<Map<String, dynamic>> auth = FirebaseFirestore.instance.collection('Users').doc(users!.phoneNo);
  TextEditingController disController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,

        title:Text('Giới thiệu về bản thân',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
        actions: [
          TextButton(onPressed: (){

              users!.description = disController.text;
              auth.update({'description': users!.description});

            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => InforPage(users: users,)),
            );
          },
          child: Text("Xong",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Container(
        child: TextField(
          controller: disController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 30,right: 10),

            hintText: users!.description != null ? '${users!.description}': 'Nhập giới thiệu về bản thân mình ik',
          ),
        ),
      ),
    );


  }
}
