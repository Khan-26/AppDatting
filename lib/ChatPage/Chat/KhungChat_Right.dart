import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KhungChat_Right extends StatefulWidget{
  const KhungChat_Right({super.key});

  @override
  State<KhungChat_Right> createState() => KhungChat_RightState();
}
class KhungChat_RightState extends State<KhungChat_Right> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

          //Khung chat
          Container(
            margin: EdgeInsets.only(top: 10,right: 10),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth:200),
            decoration: BoxDecoration(
                color: Colors.redAccent,

                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(5),bottomLeft: Radius.circular(15))
            ),
            child:  Text(
                'Day la tin nhan thu nghiem ver 1 cua tinder app duoc thuc hien boi sin hvien nam 4 cuoi khoa nganh cong nghe thong tin'
            ),

          ),

          // hinh anh
          Container(


            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(400),
              child: const Image(image: AssetImage('./assets/images/img.png'),width: 30,),
            ),
          ),
        ],
      ),
    );
  }
}