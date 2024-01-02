import 'dart:developer';

import 'package:appdatting/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:appdatting/model/Users.dart';

import 'Otp.dart';






class SignUp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    Users? users = new Users();
    var contryCode = "+84";

    bool loading = false;
    TextEditingController phoneNoController = TextEditingController();

    var phoneNo = '';
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body:Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                child: const Image(image: AssetImage('assets/images/tinder_logo.png'),width: 200,height: 100,),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign Up',style: TextStyle(color: Colors.white,fontSize: 30),
                ),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(


                    controller: phoneNoController,

                    keyboardType: TextInputType.number ,
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
                margin: EdgeInsets.only(top: 20),
                width: 300,
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.white,width: 1.0,style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: ()  async{

                    await FirebaseAuth.instance.verifyPhoneNumber(

                      phoneNumber: phoneNo = contryCode +  phoneNoController.text.trim().substring(1),


                      verificationCompleted: (PhoneAuthCredential credential) async{

                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print(e);
                      },
                      codeSent: (String verificationId, int? resendToken) {

                        Navigator.of(context).push(
                            _OtpRoute(OtpPage(verificationId: verificationId,users: users,))
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // print(verificationId);
                      },timeout: Duration(seconds: 60),
                    );
                    users.phoneNo = phoneNo ;



                  },
                  child: Text('Đăng ký',style: TextStyle(color: Colors.white,fontSize: 25),),
                )
              ),
              Container(
                child: TextButton(
                  child: Text('Hoặc là bạn đã có tài khoản ?'),
                  onPressed: ()=> {
                    Navigator.of(context).pop(),

                  },
                ),
              )
            ],
          ),
        )
    );
  }
}



Route _OtpRoute (route) {
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