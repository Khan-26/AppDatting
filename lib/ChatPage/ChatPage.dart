import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appdatting/model/Users.dart';
import 'package:appdatting/model/UserImage.dart';
import './ChatShow.dart';
import '../InforPage/InforPage.dart';
import '../HomePage/MyHomePage.dart';
class ChatPage extends StatefulWidget{
  Users? users;
  ChatPage({super.key,this.users});

  @override
  State<ChatPage> createState() => _ChatPageState(users:users);
}

class _ChatPageState extends State<ChatPage>{
  Users? users;
  _ChatPageState({this.users});
  int selectedIndex = 1;

  late CollectionReference auth = FirebaseFirestore.instance.collection('Users');

  List<Users>? list = [];
  List<Users> usersList = [];

  Future<List<Users>?>getUsers() async{
    final querySnapshot = await auth.get();
    final usersList =  querySnapshot.docs.map((doc) => Users(
      phoneNo: doc['phoneNo'] ?? '',
      name: doc['name'] ?? '',
      age: doc['age'] ?? '',
      description: doc['description'] ?? '',
      email: doc['email'] ?? '',
      sex: doc['sex'] ?? '',
      // listHobbies: List<UserHobbies>.from(doc['listHobbies'].map((hobbiesMap) => UserHobbies.fromMap(hobbiesMap)).toList()),
      listImages: List<UserImages>.from(doc['listImage'].map((imageMap) => UserImages.fromMap(imageMap)).toList()),
      // userLikeList: doc['listUserLike'] == null ? [] : List<UserLikeList>.from(doc['listUserLike'].map((likeMap) => UserLikeList.fromMap(likeMap)).toList()),
      // userLikeList: doc['listUserLike'] == null ? [] : doc['list']
    )).toList();
    return usersList;
    // print(usersList.first.id);

  }
  Future<List<Users>> listUser() async{
    list = await getUsers();

    list!.map((e){
      List phone = [];
      users!.userListChat!.map((p){
        phone.add(p.phoneNo);
      }).toList();
      if(phone.contains(e.phoneNo)){
        usersList.add(e);
      }
    }).toList();
    // users!.userListChat!.map((e)async{
    //   Users? user = await Users.getUserById(e.phoneNo!);
    //   usersList.add(user!);
    //   print(usersList);
    //
    // });
    return usersList;
  }
  @override
  Widget build(BuildContext context) {
    // print(listUser());
    return Scaffold(
        appBar: AppBar(
          leading: Text(''),
          title: Center(
            child: Image.asset('assets/images/img_1.png', width: 100,),
          ),
          backgroundColor: Colors.white,
        ),

        body:
            FutureBuilder<List<Users>>(
              future: listUser(),
              builder: (BuildContext context,AsyncSnapshot<List<Users>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while the future is loading
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  // Display an error message if the future encounters an error
                  return Text('Error: ${snapshot.error}');
                } else {
                  // usersItem = snapshot.data!;
                  // usersList = snapshot.data!;
                  // print(snapshot.data!);
                  return ListView(

                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 15),
                          alignment: Alignment.topLeft,
                          child: Text('Tin Nhắn', style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child:
                          Column(
                            children: usersList.map((e){
                              print('con');
                              print(usersList);
                              return Column(
                                children: [
                                  Container(
                                    child: ChatShow(users: e),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 105),
                                    decoration: BoxDecoration(border: Border.all(
                                        color: Color(0x4F000000),
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                                  )
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ]
                  );
                }
              }
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
              icon: Icon(Icons.chat_bubble_rounded,),
              label: 'Chat',

              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Infor',

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
                widget = MyHomePage(users: users,);
              }

              if (index == 1) {
                widget = ChatPage(users: users,);
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
}

