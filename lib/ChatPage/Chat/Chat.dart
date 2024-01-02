import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './KhungChat.dart';
import './KhungChat_Right.dart';
class Chat extends StatefulWidget{
  const Chat({super.key});

  @override
  State<Chat> createState() => ChatState();
}
class ChatState extends State<Chat> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar:AppBar(

      title:Align(
       child: Column(
         children: [
           Container(
             margin: EdgeInsets.only(bottom: 5),
             child:
             ClipRRect(
               borderRadius: BorderRadius.circular(400),
               child: const Image(image: AssetImage('./assets/images/img.png'),width: 30,),
             ),
           ),
           Container(
             child: Text('Khang',style: TextStyle(color: Colors.black,fontSize: 10),),
           )
         ],
       ),
        alignment: Alignment.center,),
      backgroundColor: Colors.redAccent,
    ) ,
    body: Container(
      margin: EdgeInsets.only(top: 10,left:10,right: 10),
      child: ListView(
        children: <Widget>[
          Container(

              child: Column(
                children: [
                  //Thoi gian
                  Container(
                    margin:EdgeInsets.only(top: 10),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('CN, 12 THG 2, ',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('20:39'),
                       ],
                      ),
                  ),
                  //khung chat nguoi gui
                  Container(
                    child: KhungChat(),
                  ),

                  Container(
                    margin:EdgeInsets.only(top: 10),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('T2, 13 THG 2, ',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('20:39'),
                      ],
                    ),
                  ),

                  //khung chat nguoi nhan
                  Container(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        KhungChat_Right(),
                      ],
                    )
                  )
                ],
              )
          ),
        ],
      ),
    ),
    bottomNavigationBar: Container(
      margin: EdgeInsets.all(15),

            child: TextField(

                decoration: InputDecoration(

                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter a search term',
                      suffixIcon: IconButton(

                        icon: Icon(Icons.send,),
                        onPressed : () => {},
                      ),

                  )
              ),
            )
         );
      }
    }