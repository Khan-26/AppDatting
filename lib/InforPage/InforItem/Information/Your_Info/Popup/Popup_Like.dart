import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:appdatting/model/Users.dart';

import '../../../../../model/AppHobbies.dart';
import '../../../../../model/UserHobbies.dart';
import '../../../../InforPage.dart';

class PopLike extends StatefulWidget{
  Users? users;
  PopLike({super.key,this.users});

  @override
  State<PopLike> createState() => PopLikeState(users: users);
}

class PopLikeState extends State<PopLike> {

  Users? users;
  PopLikeState({required this.users});

  int _selectedCount = 0;

  void updateSelectedCount(int count) {
    setState(() {
      _selectedCount = users!.listHobbies!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => InforPage(users: users,)),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),

        title:Text('Sở thích',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
      ),
        body:
        Container(

        child: ListView(
          children: [
            Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 15,right: 15),
                child:
                Text('${users!.listHobbies!.length}'+' trong tổng số 5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)

            ),

            // Container(
            //
            //     child:Wrap(
            //
            //       children: users!.listHobbies!.map(
            //           (hobby){
            //             return GestureDetector(
            //               onTap: (){
            //
            //               },
            //               child: Container(
            //                 margin: EdgeInsets.only(top:15,left: 15),
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color: Colors.redAccent
            //                 ),
            //                 child: TextButton(
            //                   onPressed: () => {},
            //                   child:Row(
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Text('${hobby.hobbies}',style: TextStyle(color: Colors.white)),
            //                       Icon(Icons.close,color:Colors.white)
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }
            //       ).toList(),
            //     )
            // ),



              //List danh sách sở thích

            Container(
              margin: EdgeInsets.only(left: 15),
              // child: Item(usersHobbiesList:users!.listHobbies!,updateSelectedCount: updateSelectedCount)
              child:   Item(users:users!,usersHobbiesList: users!.listHobbies!,updateSelectedCount: updateSelectedCount)


            ),

          ]
        ),
      )
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  
  Widget okButton = TextButton(
    style: ButtonStyle(
      backgroundColor:  MaterialStatePropertyAll<Color>(Colors.redAccent),

    ),
    child: Text("OK",style: TextStyle(color: Colors.white),),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Đã đạt số lượt thích tối đa"),
    content: Text("Bạn đã đạt số lựa chọn tối đa. Để chọn thêm, vui lòng bỏ đi một số lựa chọn khác."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Item extends StatefulWidget {
  final Function(int)? updateSelectedCount;
  late List<UserHobbies> usersHobbiesList;
  late Users users;
  Item({required this.users,required this.usersHobbiesList,this.updateSelectedCount});
  @override
  State<Item> createState() => ItemState(users:users!,usersHobbiesList: usersHobbiesList,);


}
class ItemState extends State<Item> {

  List<UserHobbies> usersHobbiesList;
  List<AppHobbies?> hobbies = AppHobbies.init();
  static List<AppHobbies?> selectedHobbies = [];
  Users users;
  ItemState({required this.users,required this.usersHobbiesList,});
  void _changeUserToApp(){
    selectedHobbies.clear();
    usersHobbiesList.forEach((userHobbies) {
      AppHobbies hobbies = AppHobbies(hobbies: userHobbies!.hobbies,state: false);
      selectedHobbies.add(hobbies);
    });
  }
  void _checkContains() {
    hobbies.map((hobby) {
      if(selectedHobbies.contains(hobby)){
       hobbies.remove(hobby);
       print(hobbies);
        print('have');
      }
      else{
        print('dont');
        hobbies.remove(hobby);
        print(hobbies);
      }


    });

    // for (var i = 0; i < hobbies.length; i++) {
    //   print('Element $i: ${hobbies[i]!.hobbies},${hobbies[i]!.state}');
    // }

  }



  void _convertHobbiesList(AppHobbies hobby) {

    usersHobbiesList.add(UserHobbies(hobbies: hobby!.hobbies,));
  }

  void removeSelectedHobby(AppHobbies appHobby) {
    // Remove the selected hobby from the _selectedHobbies list


    // Find the corresponding UserHobbies object in the _userHobbies list
    UserHobbies? userHobby = usersHobbiesList!.firstWhere(
          (userHobby) => userHobby!.hobbies == appHobby.hobbies,
    );
    // Remove the corresponding UserHobbies object from the _userHobbies list
   usersHobbiesList!.remove(userHobby);

  }
  void check(AppHobbies? hobby, List<AppHobbies?> selectedHobbies) {
    for (hobby in hobbies) {
      if (selectedHobbies.any((sh) => sh?.hobbies == hobby?.hobbies)) {
        print('have');
        hobby!.state = true;
      }
    }

  }
  bool checkToRemove(AppHobbies? hobby,List<AppHobbies?> selectedHobbies){
    if(selectedHobbies.any((element) => element?.hobbies == hobby?.hobbies)){
      print('have');
      return true;
    }
    return false;
  }

  List listAddHobbies(){
    List hoList = [];

    for (UserHobbies? userHobbies in users!.listHobbies!) {
      if (userHobbies != null) {
        // Add the non-null item to Cloud Firestore
        hoList.add({"hobbies": userHobbies.hobbies});
      }
    }
    return hoList;
  }
  @override
  void initState() {
    super.initState();
    _changeUserToApp();

    // print(_selectedHobbies);

  }
  @override
  Widget build(BuildContext context) {
    late DocumentReference<Map<String, dynamic>> auth = FirebaseFirestore.instance.collection('Users').doc(users!.phoneNo);
    // print(hobbies);
    // print(selectedHobbies);
    _checkContains();
    // print(check(hobbies,selectedHobbies));
    print(selectedHobbies);

    return Wrap(
      children: hobbies.map((hobby){
        check(hobby, selectedHobbies);
        return GestureDetector(
          onTap: () {
            setState(() {

              if(selectedHobbies.length < 5){
                hobby!.state = !hobby!.state;
                if(checkToRemove(hobby, selectedHobbies)){
                  selectedHobbies.remove(hobby!);
                  removeSelectedHobby(hobby!);
                  print(users!.listHobbies);
                  auth.update({'listHobbies': listAddHobbies()});
                  print(selectedHobbies);
                }
                else{
                  selectedHobbies.add(hobby!);
                  _convertHobbiesList(hobby!);
                  auth.update({'listHobbies': listAddHobbies()});
                }
              }
              else{
                if(checkToRemove(hobby, selectedHobbies)){
                  hobby!.state = !hobby!.state;
                  selectedHobbies.remove(hobby!);
                  removeSelectedHobby(hobby!);
                  auth.update({'listHobbies': listAddHobbies()});
                }
                else {
                  showAlertDialog(context);
                }
              }
              print(usersHobbiesList);
              widget!.updateSelectedCount!(selectedHobbies.length); // update the count
            });

          },

          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            // alignment:Alignment.center,
            margin: EdgeInsets.only(top:15,right: 15),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: hobby!.state == false ? Colors.black : Colors.redAccent
              ),

              borderRadius: BorderRadius.circular(10),
              color: Colors.white,),
            child: Text(hobby!.hobbies,style: TextStyle(color: Colors.black),),

          ),
        );
      }).toList(),
    );


  }
}
