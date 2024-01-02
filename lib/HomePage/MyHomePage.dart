import 'dart:io';
// import 'dart:js_interop';

import 'package:appdatting/Sign/LogIn/LogIn.dart';
import 'package:appdatting/model/UserHobbies.dart';
import 'package:appdatting/model/UserImage.dart';
import 'package:appdatting/model/UserLikeList.dart';
import 'package:appdatting/model/UserListChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../icons/heart_icons.dart';


import '../ChatPage/ChatPage.dart';
import '../InforPage/InforPage.dart';

import 'Bottom/Bottom_info.dart';
import '/model/Users.dart';


int imgIndex = 0;

class MyHomePage extends StatefulWidget {
  Users? users;
  MyHomePage({this.users});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState(users: users);
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Users? users;
  _MyHomePageState({this.users});

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/images/img_1.png',
            alignment: Alignment.centerLeft,
          ),
        ),
        leadingWidth: 200,

      ),
      //
      //body
      body: Swip_card(users: users),

      //bottomnavigationbar
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ), //BottomNavigationHOME
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: 'Chat',
              backgroundColor: Colors.grey), //BottomNavigationCHAT
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Infor',
          ), //BottomNavigationPERSON
        ],
        currentIndex: 0,
        selectedItemColor: Colors.redAccent,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              Widget? widget;
              if (index == 0) {
                widget = MyHomePage(users: users);
              }
              if (index == 1) {
                widget = ChatPage(users: users);
              }
              if (index == 2) {
                widget =  InforPage(users: users);
              }
              return widget!;
            }),
          );
        },
      ),
    );
  }
}

class ImageInfo extends StatefulWidget {
  SwipeItem? users;
  ImageInfo({this.users});

  @override
  State<ImageInfo> createState() => ImageInfoState(users: users);
}

class ImageInfoState extends State<ImageInfo> {
  SwipeItem? users;
  ImageInfoState({this.users});
  List<UserImages> images = [];
  @override
  Widget build(BuildContext context) {
    images = users!.content.listImages;

    return Container(
        constraints: const BoxConstraints.expand(),
        margin: const EdgeInsets.only(top: 8, right: 4, left: 4, bottom: 6),

        child: Stack(
          children: [

            //
            //List Image cua mot user
            IndexedStack(

              index: imgIndex,
               children: images.map((image){
                 return Image.network(
                   image.imageFile!.path,

                   alignment: Alignment.center,
                   height: double.infinity,
                   width: double.infinity,
                   fit: BoxFit.fill,
                 );
               }).toList(),

            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                //
                //xử lý chuyển hình ảnh
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    //left
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,

                      child: Container(
                        width: 210,
                        height: 430,
                        // color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          if(imgIndex == 0){
                          imgIndex = 0;
                          print('min');
                          }
                          else{
                          imgIndex -= 1;
                          }
                        });
                      },
                    ),
                    //
                    //right
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 210,
                        height: 430,
                        // color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          if(imgIndex == images.length-1){
                            print('max');
                          }
                          else{
                            imgIndex += 1;
                          }

                          // imgIndex == images.length ? imgIndex = images.length : imgIndex += 1;
                        });
                      },
                    ),
                  ],
                ),
                //
                //Thanh duoi
                 Bot_info(users: users),
              ],
            ),
          ],
        ));
  }
}
//
//Thẻ di chuyển card
class Swip_card extends StatefulWidget {

  Users? users;
  Swip_card({this.users});
  @override
  State<Swip_card> createState() => _Swip_cardState(users: users);
}

class _Swip_cardState extends State<Swip_card> {
  Users? users;
  _Swip_cardState({this.users});
  SwipeItem? addUsers = SwipeItem();
  late CollectionReference auth = FirebaseFirestore.instance.collection('Users');
  List<UserHobbies> hobbies = [];
  List<Users>? userList = [];
  List<SwipeItem> usersItem = <SwipeItem>[];
  MatchEngine? matchEngine;

  Future<List<Users>?>getUsers() async{
    final querySnapshot = await auth.get();
      final usersList =  querySnapshot.docs.map((doc) => Users(
        phoneNo: doc['phoneNo'] ?? '',
        name: doc['name'] ?? '',
        age: doc['age'] ?? '',
        description: doc['description'] ?? '',
        email: doc['email'] ?? '',
        sex: doc['sex'] ?? '',
        listHobbies: List<UserHobbies>.from(doc['listHobbies'].map((hobbiesMap) => UserHobbies.fromMap(hobbiesMap)).toList()),
        listImages: List<UserImages>.from(doc['listImage'].map((imageMap) => UserImages.fromMap(imageMap)).toList()),
        userLikeList: doc['listUserLike'] == null ? [] : List<UserLikeList>.from(doc['listUserLike'].map((likeMap) => UserLikeList.fromMap(likeMap)).toList()),
        // userLikeList: doc['listUserLike'] == null ? [] : doc['list']
      )).toList();
      return usersList;
    // print(usersList.first.id);

  }

  Future<List<SwipeItem>> listUsers() async {

    // List<UserHobbies> hobbiesList = [];
    // hobbiesList = users!.listHobbies!;
    // await getUsers();
    // usersItem.map((users){
    //   if(users.content.listHobbies.contains(UserHobbies(hobbies: hobbiesList.map((hobbies){
    //     hobbies!.hobbies!
    //   })))
    // });
    userList = await getUsers();
    print(users!.userLikeList!);
    // List<Users> usersList = userList!.where((user) => users!.listHobbies!.contains(user!.listHobbies)).toList();
    List<Users> usersList = [];
    userList!.map((user){
      users!.listHobbies!.map((hobbies){
       user.listHobbies!.map((uhobbies){
         if(!usersList.contains(user)){
           if(uhobbies.hobbies == hobbies.hobbies){
             if(user.phoneNo != users!.phoneNo){
               usersList.add(user);
             }
           }
         }
       }).toList();
      }).toList();
    }).toList();
    usersItem.clear();
    for (int i = 0; i < usersList.length; i++) {

        usersItem.add(SwipeItem(
            content: Users(
              phoneNo: usersList[i].phoneNo,
              name: usersList[i].name,
              age: usersList[i].age,
              description: usersList[i].description,
              email: usersList[i].email,
              sex: usersList[i].sex,
              listHobbies: usersList[i].listHobbies,
              listImages: usersList[i].listImages,
              userLikeList: usersList[i].userLikeList,
            )
        ));

    }
    matchEngine = MatchEngine(swipeItems: usersItem);
    print(usersItem);
    return usersItem;
  }

  List listAddUserLike(){
    List? userList = [];
    for (UserLikeList user in users!.userLikeList!) {
      if (user != null) {
        // Add the non-null item to Cloud Firestore
        userList.add({"phoneNo": user.phoneNo});
      }
      // print(userImage!.imageFile.toString().substring(8,80));
    }
    return userList;
  }

  List listAddUserChat(Users users){
    List? userList = [];
    for (UserListChat? user in users!.userListChat!) {
      if (user != null) {
        // Add the non-null item to Cloud Firestore
        userList.add({"phoneNo": user.phoneNo});
      }
      // print(userImage!.imageFile.toString().substring(8,80));
    }
    return userList;
  }

  void addUserLike(Users addUsers){
    // List<UserListChat> listChat = [] ;
    print(addUsers!.phoneNo);
    // if(users!.userLikeList == null){
    //   List<UserLikeList> list = [];
    //   list.add(UserLikeList(phoneNo: addUsers!.phoneNo));
    //   users!.userLikeList = list;
    // }
    // else{
    //   if(users!.userLikeList!.contains(addUsers!.phoneNo)){
    //     // users!.userLikeList!.add(UserLikeList(phoneNo: addUsers!.phoneNo));
    //     print('contains');
    //   }
    // }

    if(!users!.userLikeList!.contains(UserLikeList(phoneNo: addUsers.phoneNo))){
      users!.userLikeList!.add(UserLikeList(phoneNo: addUsers!.phoneNo!));
      // print('did not contains');
    }
    else{
      print('contains');
    }
    auth.doc(users!.phoneNo).update({
      "listUserLike" : listAddUserLike()
    });

    List add = [];
    addUsers!.userLikeList!.map((e) => {
      add.add(e.phoneNo)
    }).toList();
    List use = [];
    users!.userLikeList!.map((e) => {
      use.add(e.phoneNo)
    }).toList();

    // if(users!.userLikeList!.contains(UserLikeList(phoneNo: addUsers.phoneNo)) && addUsers.userLikeList!.contains(UserLikeList(phoneNo: users!.phoneNo)))
    if(add.contains(users!.phoneNo) && use.contains(addUsers!.phoneNo))
      {
        // print('conatins');

        users!.userListChat!.add(UserListChat(phoneNo: addUsers!.phoneNo));
        // print(users!.userListChat);
        if(addUsers!.userListChat == null){
          List<UserListChat> addList = [];
          addList.add(UserListChat(phoneNo: users!.phoneNo));
          addUsers!.userListChat = addList ;
        }
        else{
          addUsers!.userListChat!.add(UserListChat(phoneNo: users!.phoneNo));
        }
        // // print(addUsers.userListChat);
        auth.doc(users!.phoneNo).update({
          "listUserChat" :  listAddUserChat(users!)
        });
        auth.doc(addUsers!.phoneNo).update({
        "listUserChat" :  listAddUserChat(addUsers!)
        });
      }
    else{
      print('did not contains');
    }


    // print(users!.userLikeList);
  }

  @override
  Widget build(BuildContext context) {

    print(users!.userListChat);
    listUsers();
    return Scaffold(
        body: FutureBuilder<List<SwipeItem>>(
          future: listUsers(),
          builder: (BuildContext context,AsyncSnapshot<List<SwipeItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while the future is loading
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if the future encounters an error
              return Text('Error: ${snapshot.error}');
            } else {
              usersItem = snapshot.data!;

              // print(snapshot.data);
              return Stack(
                  children: [
                    SwipeCards(

                      matchEngine: matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        addUsers = usersItem[index];

                        return Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                          alignment: Alignment.center,
                          // child: Text('test'),
                          child: ImageInfo(users: snapshot.data![index]),
                        );
                      },

                      //
                      //Thông báo hết stack
                      onStackFinished: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Stack Finished"),
                              duration: Duration(milliseconds: 500),
                            ));
                      },

                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      upSwipeAllowed: false,
                      //

                      //Thẻ tag Like --- Nope
                      likeTag: Container(

                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)
                        ),
                        child: const Text('Like', style: TextStyle(
                            color: Colors.green, fontSize: 40)),
                      ),
                      nopeTag: Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)
                        ),
                        child: const Text('Nope!!',
                            style: TextStyle(color: Colors.red, fontSize: 40)),
                      ),

                    )
                  ]

              );
            }
          }
        ),

        //Nút Like và nút Nope trong FloatingButton
        floatingActionButton: Container(
        constraints: const BoxConstraints(minWidth: 400, maxWidth: double.infinity),
        margin: const EdgeInsets.only(left: 35,right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            //icon XXXXXXXXXX
            Container(
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red,width:4.0),

                ),
                child: IconButton(
                  icon:  const Icon(Icons.cancel,color: Colors.red,),
                  onPressed: () => {

                    matchEngine!.currentItem?.nope()

                  },
                )

            ),
            //icon TIMMMM
            Container(
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green,width:4.0),

                ),
                child: IconButton(

                  icon:  const Icon(Heart.heart_filled,color: Colors.green,),
                  onPressed: () => {
                  print(addUsers!.content.name),

                    addUserLike(addUsers!.content),
                  matchEngine!.currentItem?.like()





                  },
                )

            )
          ],
        ),
      )
    );

  }



}



