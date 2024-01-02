import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../model/Users.dart';

class Age extends StatefulWidget{
  SwipeItem? users;
  Age({this.users});
  @override
  State<StatefulWidget> createState() => AgeState(users: users);
}



class AgeState extends State<Age>{
  SwipeItem? users;
  AgeState({this.users});
  @override
  Widget build(BuildContext context){
    return Container(

        child:
        Text('${users!.content.age}',style:TextStyle(color: Colors.white,fontSize: 25,),)

    );
  }
}

