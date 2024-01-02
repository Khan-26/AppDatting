import 'dart:developer';

import 'package:appdatting/HomePage/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/Users.dart';
import 'FormAddImg.dart';
const List<String> list = <String>['Nam', 'Nữ', 'Gay', 'Les'];
String dropdownValue = list.first;

class ActionSignUp extends StatefulWidget {
  Users? user;
  ActionSignUp({this.user});

  @override
  State<ActionSignUp> createState() => _ActionSignUpState(user: user);
}

class _ActionSignUpState extends State<ActionSignUp> {
  CollectionReference userInfor = FirebaseFirestore.instance.collection('Users');
  Users? user;
  _ActionSignUpState({this.user});
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(

                  margin: EdgeInsets.only(top: 5),
                  child: Column(

                    children: [

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Giới tính của bạn', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Container(
                        child: DropdownButton<String>(

                          isExpanded: true,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {

                              dropdownValue = value!;

                            });


                          },
                          items: list.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(

                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                //họ và tên
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Tên của bạn', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30, right: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, style: BorderStyle.solid),
                        ),
                        hintText: 'Nhập họ tên bạn',
                      )
                  ),
                ),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                //họ và tên
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Tuổi của bạn', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(

                      contentPadding: EdgeInsets.only(left: 30, right: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0, style: BorderStyle.solid),
                      ),
                    hintText: 'Nhập tuổi của bạn',
                    )
                  ),
                )
              ],
            ),
          ),

          Container(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(

                border: Border.all(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () =>
                {
                  user!.name = nameController.text,
                  user!.age = ageController.text,
                  user!.sex = dropdownValue,
                  // print(user!.phoneNo),
                  // print(user!.phoneNo),
                  // user!.setUserInfor(userInfor,nameController.text, ageController.text, dropdownValue),
                  Navigator.of(context).push(_SignUpRoute(FormAddImg(users: user))),
                },
                child: Text('Chuyển tiếp', style: TextStyle(color: Colors.redAccent)),
              ),
            )
          )


        ],
      ),
    );
  }

  Route _SignUpRoute(route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}


class FormSignUp extends StatelessWidget{
  Users? users;
  FormSignUp({this.users});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Tôi là ai ?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
      ),
      body: ActionSignUp(user:users)
    );
  }
}


