import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../model/Users.dart';

class Name extends StatelessWidget{
  SwipeItem? users;
  Name({this.users});

  @override
  Widget build(BuildContext context){
    return Container(
        child:
        Text('${users!.content.name}',style:TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),)

    );
  }
}

