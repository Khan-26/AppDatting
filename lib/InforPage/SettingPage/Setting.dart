import 'package:appdatting/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Sign/LogIn/LogIn.dart';
import '../../model/Users.dart';
class Setting extends StatefulWidget{
  Users users;
  Setting({required this.users});

  @override
  State<Setting> createState() => _SettingState(users: users);
}

class _SettingState extends State<Setting> {
  Users users;
  _SettingState({required this.users});
  late DocumentReference<Map<String, dynamic>> auth = FirebaseFirestore.instance.collection('Users').doc(users!.phoneNo);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text('Cài đặt tài khoản',style: TextStyle(color: Colors.white),),

      ),
      body: Container(
        decoration: BoxDecoration(
        color: Color.fromARGB(90,206, 206, 206),),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top:20,left: 25),
              alignment: Alignment.topLeft,
              child: Text(

                'Tài khoản của tôi',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
              ),
            ),
            //////// Số điện thoại
            Container(
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(

                  color: Colors.white,
                ),
                child: TextButton(

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child:
                              Text('Số Điện Thoại',style: TextStyle(color: Colors.black),),

                        ),
                      ),
                      Container(

                        alignment: Alignment.centerRight,
                        child:Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(right: 10),
                                  child: Text('${users.phoneNo}',style: TextStyle(color: Colors.black),),
                                ),



                            ]
                          )
                      )
                  ],
                  ),
                  onPressed: () {}
            ),
            ),

            /////////
            //////// Email
            Container(

              decoration: BoxDecoration(

                color: Colors.white,
              ),
              child: TextButton(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child:
                        Text('Email',style: TextStyle(color: Colors.black),),

                      ),
                    ),
                    Container(

                        alignment: Alignment.centerRight,
                        child:Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:EdgeInsets.only(right: 10),
                                child: widget.users!.email == null ? Text("Nhập email của bạn",style: TextStyle(color: Colors.black),)
                                    :
                                Text("${widget.users!.email!}",style: TextStyle(color: Colors.black),),
                              ),
                              Icon
                                (
                                  Icons.arrow_forward_outlined,
                                  size: 22,
                                  color: Colors.redAccent
                              ),


                            ]
                        )
                    )
                  ],
                ),
                onPressed: () => {
                  setState((){
                    _EmailDialog(context, widget.users);
                  })
                },
              ),
            ),
            SizedBox(height: 100,),
            ////////
            //////// Đăng xuất
            Container(
              decoration: BoxDecoration(

                color: Colors.white,
              ),
              child: TextButton(
                onPressed: () => {
                  _LogoutDialog(context),
                },
                child: Text('Đăng xuất',style: TextStyle(color: Colors.redAccent,fontSize: 20),),
              ),
            )
          ],
        ),
      ),
    );



  }
  TextEditingController _EmailFieldController = TextEditingController();
  _EmailDialog(BuildContext context, Users? users) async {
    void addEmail(){

      users!.email = _EmailFieldController.text;
    }
    return showDialog(

        context: context,
        builder: (context) {
          return AlertDialog(

            title: Text('Cập nhật Email của bạn'),
            content: TextField(
                controller: _EmailFieldController,
                decoration: users!.email == null ?
                InputDecoration(hintText: "Nhập email của bạn")
                    :
                InputDecoration(hintText: "${users!.email}")
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text('Oke!',style: TextStyle(color: Colors.green),),
                onPressed: () {

                  setState(() {
                    addEmail();
                    users!.email = _EmailFieldController.text;
                    auth.update({'email': users!.email});
                    Navigator.of(context).pop(users);
                  });
                },
              ),

            ],
          );
        });
  }
  //Đăng xuất
  _LogoutDialog(BuildContext context) async {
    return  showDialog(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context)
        {
          return AlertDialog(
              title: Text('Bạn muốn đăng xuất?'),

              actions: <Widget>[
                TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Đăng xuất', style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                ),
              ]
          );
        });
  }
}
// TextEditingController _SdtFieldController = TextEditingController();
// _SdtDialog(BuildContext context) async {
//   return showDialog(
//
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//
//           title: Text('Cập nhật số điện thoại của bạn'),
//           content: TextField(
//             controller: _SdtFieldController,
//             decoration: InputDecoration(hintText: "0703565928"),
//             keyboardType: TextInputType.number,
//           ),
//           actions: <Widget>[
//             new TextButton(
//               child: new Text('Oke!',style: TextStyle(color: Colors.green),),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//
//           ],
//         );
//       });
// }









