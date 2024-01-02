import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'Popup/Popup_Descrip.dart';
import 'Popup/Popup_Like.dart';
import 'Popup/Popup_Sex.dart';
import 'package:appdatting/model/Users.dart';
import 'package:appdatting/model/UserHobbies.dart';
class About_Your extends StatefulWidget{
  Users? users;
   About_Your({super.key,this.users});

  @override
  State<StatefulWidget> createState() => About_YourState(users:users);
}

class About_YourState extends State<About_Your>{
  Users? users;
  About_YourState({this.users});

  @override
  Widget build(BuildContext context){
    return Column(
        children:[
          //
          // Gioi thieu
          //
          Container(
            margin: EdgeInsets.only(top:20,left: 25,bottom: 15),
            alignment: Alignment.topLeft,
            child: Text(

              'GIỚI THIỆU BẢN THÂN',style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            ),
          ),
          //BOX NHẬP GIỚI THIỆU//////////////////////
          Container(
            // alignment: Alignment.centerLeft,
            // margin: EdgeInsets.only(left: 25,right: 5),
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: Colors.white,

            ),
            child: Des(users:users),
            // child: TextField(
            //   controller: disController,
            //   keyboardType: TextInputType.multiline,
            //   maxLines: null,
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.only(left: 30,right: 10),
            //
            //     hintText: 'Nhập giới thiệu về bản thân mình ik',
            //   ),
            //   onEditingComplete:() async {
            //      setState(() {
            //        if(users!.description != null)
            //          {
            //            users!.description = disController.text;
            //          }
            //        else{
            //          users!.description = '';
            //        }
            //
            //     });
            //     print(disController.text);
            //
            //   },
            // ),
          ),
          //
          // SỞ THÍCH
          //
          Container(
            margin: EdgeInsets.only(top:20,left: 25),
            alignment: Alignment.topLeft,
            child: Text(

              'SỞ THÍCH',style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            ),
          ),
          //// BOX CHỌN SỞ THÍCH ////////////////////////
          Like(users: users),



          //
          // GIỚI TÍNH
          //
          Container(
            margin: EdgeInsets.only(top:20,left: 25),
            alignment: Alignment.topLeft,
            child: Text(

              'GIỚI TÍNH',style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            ),
          ),
          /////////// BOX CHỌN GIỚI TÍNH ////////////////
         Sex(users: users),
        ]
    );
  }
}

//
//like
class Like extends StatefulWidget{
  Like({super.key,this.users});
  Users? users;
  @override
  State<Like> createState() => LikeState(users: users);
}

class LikeState extends State<Like>{
  Users? users;
  LikeState({this.users});
  // late List<UserHobbies>? list = users?.listHobbies;
  @override
  Widget build(BuildContext context){
    return Container(
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(

          color: Colors.white,
        ),
        child: TextButton(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 360,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Wrap(

                    // children: [
                    //   Text('Bóng Rổ, ',style: TextStyle(color: Colors.black),),
                    //   Text('Du lịch, ',style: TextStyle(color: Colors.black)),
                    //   Text('Rượu châm banh và rượu Soju, ',style: TextStyle(color: Colors.black)),
                    //   Text('Phượt, ',style: TextStyle(color: Colors.black)),
                    //   Text('Tuyển thủ chuyên nghiệp, ',style: TextStyle(color: Colors.black)),
                    // ],
                    children: users!.listHobbies!.map((hobby){
                      return Text(
                        '${hobby.hobbies},' + ' '
                        ,style: TextStyle(color: Colors.black)
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Icon
                  (
                    Icons.arrow_forward_outlined,
                    size: 20,
                    color: Colors.redAccent
                ),

              )
            ],
          ),
          onPressed: () => {
            // print(users!.listHobbies),
            Navigator.of(context).push(_YourRoute(PopLike(users:users)))
          },
        )
    );
  }
}


//
//sex
class Sex extends StatefulWidget{
  Users? users;
  Sex({super.key,this.users});

  @override
  State<Sex> createState() => SexState(users: users);
}

class SexState extends State<Sex>{
  Users? users;
  SexState({this.users});
  @override
  Widget build(BuildContext context){
    return  Container( margin: EdgeInsets.only(top: 15,bottom: 40),
        decoration: BoxDecoration(

          color: Colors.white,
        ),
        child: TextButton(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 360,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Wrap(

                    children: [
                      Text(users!.sex!,style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Icon
                  (
                    Icons.arrow_forward_outlined,
                    size: 22,
                    color: Colors.redAccent
                ),

              )
            ],
          ),
          //
          //XỬ LÝ ontap trang giới tính
          onPressed: () => {
            Navigator.of(context).push(_YourRoute(PopSex(users: users)))
          },
        )
    );
  }
}

class Des extends StatelessWidget {
  Users? users;
  Des({this.users});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child:
          TextButton(
            onPressed: (){
              Navigator.of(context).push(_YourRoute(PopDescrip(users: users)));
            },
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 300,minWidth: 100,),
                  child: Wrap(
                    children: [
                      // Text('${users!.description}')
                      users!.description == '' || users!.description == null ? Text("Nhập giới thiệu về bản thân",style: TextStyle(color:Colors.black),) : Text("${users!.description}",style: TextStyle(color: Colors.black)),
                      Spacer(),
                    ],

                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Icon
                    (
                      Icons.arrow_forward_outlined,
                      size: 22,
                      color: Colors.redAccent
                  ),

                )
              ],
            )
      ),
    );
  }
}




Route _YourRoute(route) {
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