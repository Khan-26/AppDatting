
import 'package:appdatting/Sign/LogIn/LogIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SettingPage/Setting.dart';

import '../ChatPage/ChatPage.dart';


import '../HomePage/MyHomePage.dart';

import 'package:appdatting/model/Users.dart';



import 'Scroll_Info.dart';
class InforPage extends StatefulWidget{
  Users? users;
  InforPage({super.key,this.users});

  @override
  State<InforPage> createState() => _InforPageState(users:users);
}

class _InforPageState extends State<InforPage>{
  int selectedIndex = 2;
  Users? users;
  _InforPageState({this.users});
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.white,
        leading:
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Image.asset('assets/images/img_1.png',alignment: Alignment.centerLeft,),
        ),
        leadingWidth: 200,
        actions: <Widget>[

                Container(

                    child:
                    TextButton(onPressed: (){
                      Navigator.of(context).push(_SettingRoute());
                    }, child: const Icon(Icons.settings,color: Colors.grey,)
                    )
                ),



        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(90,206, 206, 206),
        ),
        child:ListView(

            children: <Widget>[
            Scroll_Info(users:users)
          ]
        ),
      ),

      bottomNavigationBar:BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: 'Chat',
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Infor',
              backgroundColor: Colors.black
          ),

        ],

        currentIndex: selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: (int index){
          this.setState(() {
            selectedIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)
            {
              Widget? widget;
              if (index == 0) {
                widget = MyHomePage(users:users);
              }
              if (index == 1) {
                widget = ChatPage(users:users);
              }
              if (index == 2) {
                widget = InforPage(users: users,);
              }
              return widget!;
            }
            ),);
        },
      ),
    );
  }
  Route _SettingRoute() {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Setting(users: users!),
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
}

