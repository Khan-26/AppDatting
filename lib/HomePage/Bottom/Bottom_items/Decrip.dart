import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../model/UserHobbies.dart';
import '../../../model/Users.dart';

class Decrip extends StatefulWidget{
  SwipeItem? users;
  Decrip({this.users});
  @override
  State<StatefulWidget> createState() => DecripState(users: users);
}



class DecripState extends State<Decrip>{
  SwipeItem? users;
  DecripState({this.users});
  List<UserHobbies> hobbies = [];
  @override
  Widget build(BuildContext context){
    hobbies = users!.content.listHobbies;
    return ConstrainedBox(

          constraints: BoxConstraints(maxWidth: 350,minWidth: 140),
          //   constraints: BoxConstraints(maxWidth: 200,maxHeight: 100),

              child: Wrap(

                spacing: 10,
                runSpacing: 5.0,
              children: hobbies.take(3).map((hobby) {
                return Container(
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:Colors.grey,
                        ),


                        padding:EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                        child:
                        Text('${hobby!.hobbies}',style:TextStyle(color:Colors.white,fontSize: 18)),
                      );
              }).toList(),

            )



    );
  }
}

