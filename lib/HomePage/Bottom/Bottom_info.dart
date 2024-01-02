import 'package:appdatting/HomePage/Bottom/InforShow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../model/Users.dart';
import 'Bottom_items/Name.dart';
import 'Bottom_items/Age.dart';
import 'Bottom_items/Decrip.dart';

class Bot_info extends StatefulWidget{
  SwipeItem? users;
  Bot_info({this.users});
  @override
  State<StatefulWidget> createState() => Bot_infoState(users: users);
}



class Bot_infoState extends State<Bot_info>{
  SwipeItem? users;
  Bot_infoState({this.users});
  @override
  Widget build(BuildContext context){
    return Container(
        alignment:Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black12, Colors.black,Colors.black87],
          ),
        ),
        padding: EdgeInsets.only(bottom: 60),
        child:
        Container(
          margin: new EdgeInsets.only(left:15,right: 15,bottom: 15),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Thong tin
              Container(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:Row(
                        children: [
                          Container(
                            child: Name(users: users),
                          ),
                          Container(

                            margin: new EdgeInsets.only(left: 15,top: 8),
                            child: Age(users: users),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.topLeft,
                      child: Decrip(users: users),
                    ),

                  ],
                ),
              ),
              //button info
              Container(
                  child :Column(
                    children : <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_circle_up,color: Colors.white,size: 30,) ,
                        onPressed: () => setState(() {
                          Navigator.of(context).push(_createRoute());
                        }),
                      )
                    ],
                  )
              ),
            ],
          ),
        ),

    );
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => InforShow(users: users),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
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
}



