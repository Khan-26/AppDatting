import 'package:appdatting/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appdatting/model/Users.dart';
import '../SignUp/SignUp.dart';

import 'Otp_login.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference user = FirebaseFirestore.instance.collection('Users');
class LogIn extends StatelessWidget{
  LogIn({super.key});


  @override
  Widget build(BuildContext context){
    final countryCode = '+84';
    var phoneNumber = '';
    final phoneNo = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body:Container(
        alignment: Alignment.center,
        child: Column(


          children: [
            Container(
              child: const Image(image: AssetImage('assets/images/tinder_logo.png'),width: 200,height: 100,),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Log In',style: TextStyle(color: Colors.white,fontSize: 30),
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                  controller: phoneNo,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30,right: 10),
                    border: OutlineInputBorder(
                      borderSide:BorderSide.none,
                    ),
                    hintText: 'Nhập số điện thoại',
                  )
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 300,
              decoration: BoxDecoration(
                border:Border.all(color: Colors.white,width: 1.0,style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                onPressed: () async{

                  // users.setUser(phone)
                  final userDoc = await user.doc(countryCode + phoneNo.text.trim().substring(1)).get();
                  Users? users = await Users.getUserById(userDoc.id);

                  if(userDoc.exists){
                    await FirebaseAuth.instance.verifyPhoneNumber(

                      phoneNumber:userDoc.id,


                      verificationCompleted: (PhoneAuthCredential credential) async{

                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print(e);
                      },
                      codeSent: (String verificationId, int? resendToken) {

                        Navigator.of(context).push(
                            _LogInRoute(Otp_LoginPage(verificationId: verificationId,users: users))
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // print(verificationId);
                      },timeout: Duration(seconds: 60),
                    );
                    final phone = userDoc.toString();
                    print(phone);
                    // Navigator.of(context).push(
                    //     _LogInRoute(Otp_loginPage(verificationId: verificationId,users: users,))
                    // );

                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Phone number not found'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Đăng nhập',style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              decoration: BoxDecoration(
                border:Border.all(color: Colors.white,width: 1.0,style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                onPressed: () => {
                  Navigator.of(context).push(
                   _SignUpRoute(SignUp())
                  )
                },
                child: Text('Đăng ký',style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            ),
          ],
        ),
      )
    );
  }
}

Route _LogInRoute(route) {
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

Route _SignUpRoute(route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
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



