



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './ChatShowItem/Name_and_chatshow.dart';
import './Chat/Chat.dart';
import 'package:appdatting/model/Users.dart';
class ChatShow extends StatefulWidget{
  ChatShow({this.users});
  Users? users;

  @override
  State<ChatShow> createState() => ChatShowState(users: users);
}

class ChatShowState extends State<ChatShow>{
  Users? users;
  ChatShowState({this.users});




  @override
  Widget build(BuildContext context) {
    return TextButton(

      //dieu huong
        onPressed: (){
          Navigator.of(context).push(_ChatRoute());
        },

      style: ButtonStyle(

        foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
      ),

      child:Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20,left: 15),
        child: Row(

          // children: users!.userListChat!.map((e){
          //   return Row(
              children:[
                Container(
                  alignment: Alignment.centerLeft,
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    // child: const Image(image: ,width: 70,),
                    child: Image.network(users!.listImages!.first!.imageFile!.path,width: 70,),
                  ),
                ),
                //
                //Thong tin
                Container(
                  constraints: BoxConstraints(maxWidth: 300,minWidth: 200,),
                  child:
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Name_Chat(users : users),
                  ),
                ),


              ]
          //   );
          // }).toList(),
        ),
      )
    );
  }
}


Route _ChatRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Chat(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);
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

