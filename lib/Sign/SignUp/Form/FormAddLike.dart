import 'package:appdatting/HomePage/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../model/AppHobbies.dart';
import '../../../model/UserHobbies.dart';
import 'package:appdatting/model/Users.dart';

class FormAddLike extends StatefulWidget{
  Users? users;

  FormAddLike({this.users});

  @override
  State<FormAddLike> createState() => FormAddLikeState(users: users);
}

class FormAddLikeState extends State<FormAddLike> {
  Users? users;


  // List<UserHobbies>? userHobbies;

  FormAddLikeState({this.users});

  List? userHobbies;

  int _selectedCount = 0;

  void updateSelectedCount(int count) {
    setState(() {
      _selectedCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Chọn sở thích của bạn ikkk',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
            actions: [
                TextButton(
                  onPressed: ()=>{
                    users!.listHobbies = ItemState._userHobbies.toList(),
                    users!.addUsers(),
                    Navigator.of(context).push(_LikeRoute(MyHomePage(users: users))),
                  },
                      child: Text(
                             'Xong',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                         )
                      ),
                  ]
                ),
        body:
        Container(

          child: Column(
              children: [
                //hien thi so luong so thich da chon
                Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 15,right: 15),
                    child:
                    Text('${_selectedCount}'+' trong tổng số 5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)

                ),

//Thanh tim kiem
                //Thanh tìm kiếm
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Color.fromARGB(100, 208, 206, 206),
                //   ),
                //   margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                //   child: TextField(
                //
                //       maxLines: null,
                //       decoration: InputDecoration(
                //           contentPadding: EdgeInsets.only(left: 30,right: 10,top: 15),
                //           prefixIcon: Icon(Icons.search),
                //           hintText:'Tìm kiếm',
                //           border: OutlineInputBorder(
                //             borderSide: BorderSide.none,
                //           )
                //
                //       )
                //   ),
                // ),



                //List danh sách sở thích
                Container(
                    child:Item(updateSelectedCount)
                ),
              ]
          ),
        )
    );

  }
}

class Item extends StatefulWidget {
  final Function(int) updateSelectedCount;

  Item(this.updateSelectedCount);
  @override
  State<Item> createState() => ItemState();


}
class ItemState extends State<Item> {
  List<AppHobbies?> hobbies = AppHobbies.init();
  static List<AppHobbies?> _selectedHobbies = [] ;
  static List<UserHobbies> _userHobbies = [];

  void _convertHobbiesList() {
    _userHobbies.clear();
    for (var appHobbies in _selectedHobbies) {
      UserHobbies userHobbies = UserHobbies(hobbies: appHobbies!.hobbies);
      _userHobbies.add(userHobbies);
    }
  }

  void removeSelectedHobby(AppHobbies appHobby) {
    // Remove the selected hobby from the _selectedHobbies list


    // Find the corresponding UserHobbies object in the _userHobbies list
    UserHobbies? userHobby = _userHobbies.firstWhere(
          (userHobby) => userHobby.hobbies == appHobby.hobbies,
    );
      // Remove the corresponding UserHobbies object from the _userHobbies list
      _userHobbies.remove(userHobby);

  }



  // List<UserHobbies>? userHobbies;
  @override
  Widget build(BuildContext context) {
    return Wrap(

      children: hobbies.map((hobby){
        return GestureDetector(
          onTap: () {
            setState(() {

                if(_selectedHobbies.length < 5){
                  hobby!.state = !hobby.state;
                  if(hobby.state) {
                    _selectedHobbies.add(hobby!);
                    _convertHobbiesList();
                  }
                  else{
                    _selectedHobbies.remove(hobby!);
                    removeSelectedHobby(hobby!);
                  }
                }
                else{
                  if(_selectedHobbies.contains(hobby!)){
                    hobby!.state = !hobby.state;
                    _selectedHobbies.remove(hobby!);
                    removeSelectedHobby(hobby!);
                  }
                  else {
                    showAlertDialog(context);
                  }
                }
                widget.updateSelectedCount(_selectedHobbies.length); // update the count
            });
            // print(_selectedHobbies[index]!.hobbies);

            print(hobby.hobbies);
            print(hobby.state);
            print(_selectedHobbies.toList());
            print(_userHobbies.toList());
            // _userHobbies = _selectedHobbies.map((appHobbies) => UserHobbies(hobbies: appHobbies!.hobbies,state: appHobbies.state)).toList();


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

Route _LikeRoute (route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
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



