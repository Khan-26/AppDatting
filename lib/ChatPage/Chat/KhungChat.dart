import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KhungChat extends StatefulWidget{
  const KhungChat({super.key});

  @override
  State<KhungChat> createState() => KhungChatState();
}
class KhungChatState extends State<KhungChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // hinh anh
          Container(

            margin: EdgeInsets.only(right: 10),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(400),
              child: const Image(image: AssetImage('./assets/images/img.png'),width: 30,),
            ),
          ),
          //Khung chat
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth:200),
            decoration: BoxDecoration(
              color: Color.fromARGB(90,206, 206, 206),

              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(15),bottomLeft: Radius.circular(5))
            ),
            child:  Text(
              'Day la tin nhan thu nghiem ver 1 cua tinder app duoc thuc hien boi sin hvien nam 4 cuoi khoa nganh cong nghe thong tin'
            ),

          ),

        ],
      ),
    );
  }
}