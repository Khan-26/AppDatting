
import 'package:appdatting/InforPage/InforPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:appdatting/model/Users.dart';


enum Sex {Nam, Nu, Gay, Les}
class PopSex extends StatefulWidget{
  Users? users;
  PopSex({super.key,this.users});

  @override
  State<PopSex> createState() => PopSexState(users: users);
}

class PopSexState extends State<PopSex> {
  Sex? _site;


  Users? users;
 PopSexState({this.users});
 late DocumentReference<Map<String, dynamic>> auth = FirebaseFirestore.instance.collection('Users').doc(users!.phoneNo);

  @override
  void initState() {
    super.initState();
    // set the initial value of _site to match the value of users!.sex
    _site = Sex.values.firstWhere((e) => e.toString().substring(4) == users!.sex);
  }

 ListTile buildListTile(Sex value, String title) {
   return ListTile(
     title: Text(title),
     leading: Radio<Sex>(
       value: value,
       groupValue: _site,
       onChanged: (Sex? newValue) {
         setState(() {
           _site = newValue!;
           users!.sex = newValue.toString().substring(4);
           auth.update({'sex': users!.sex});
           Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => InforPage(users: users,)),
           );
         });
       },
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.redAccent,
        title: Center(

          child: Text('Tôi là ai ?',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(90,206, 206, 206),
        ),
        child: Column(

          children: Sex.values.map((value)  {
              return buildListTile(value, value.toString().substring(4));
          }).toList(),
        ),
      ),

    );
  }
}
