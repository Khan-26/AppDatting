import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appdatting/model/Users.dart';

class Name_Chat extends StatefulWidget{
  Users? users;
   Name_Chat({this.users});

  @override
  State<Name_Chat> createState() => Name_ChatState(users: users);
}
class Name_ChatState extends State<Name_Chat> {
  Users? users;
  Name_ChatState({this.users});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Tên
          Container(

            margin: EdgeInsets.only(left: 10),
            child:  Row(
              children:  [
                Container(
                  child: Text(users!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(300),color: Colors.green),
                ),
              ],
          )


          ),
          //Nội dung chat

          Container(
            constraints: BoxConstraints(maxWidth: 300,minWidth: 100,),
            margin: EdgeInsets.only(left: 10),
            child: Wrap(
              children: [
                Text('Nay di làm khong co ve an com toi voi em duoc nen chac tuan sau anh bu cho ha',),
              ],
            )
          ),
        ],
      ),
    );
  }
}