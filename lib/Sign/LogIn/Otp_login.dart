import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';
import '../../HomePage/MyHomePage.dart';
import 'package:appdatting/main.dart';
import 'package:appdatting/model/Users.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


FirebaseApp? dApp = Firebase.app('appdating');
FirebaseAuth auth = FirebaseAuth.instanceFor(app: dApp!);




// Future<bool> verifyOTP(String otp) async{
//   var credentials = await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp));
//   return credentials.user != null ? true : false ;
// }


class Otp_LoginPage extends StatelessWidget {
  Users? users;
  final verificationId ;





  Otp_LoginPage({required this.verificationId, this.users});

  TextEditingController codeController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {


    return Scaffold(

        body:Column(
          children: [
            SizedBox(height: 50,),
            //Mui ten quay ve <
            Container(
              margin: EdgeInsets.only(left: 10),
              alignment:Alignment.centerLeft,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,color:Colors.grey),
                iconSize: 35,
              ),
            ),
            Container(
              child:Text('Nhập mã OTP của bạn',style:
              TextStyle(
                fontWeight:FontWeight.bold,
                fontSize: 35,
              )
              ),
            ),
            Container(
                margin:EdgeInsets.only(left:30),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                        '${users!.phoneNo}'
                    ),
                    TextButton(
                        onPressed: () async{

                          await FirebaseAuth.instance.verifyPhoneNumber(

                            phoneNumber:users!.phoneNo,


                            verificationCompleted: (PhoneAuthCredential credential) async{

                            },
                            verificationFailed: (FirebaseAuthException e) {
                              print(e);
                            },
                            codeSent: (String verificationId, int? resendToken) {

                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              // print(verificationId);
                            },timeout: Duration(seconds: 60),
                          );
                          // print(users.phoneNo);
                        },
                        child:Text('Gửi lại')
                    )
                  ],
                )
            ),
            Container(
                child:Pinput(
                  controller:codeController,
                  keyboardType: TextInputType.number,
                  length:6,
                  showCursor:true,
                )
            ),
            Container(
              margin:EdgeInsets.only(top:30),
              child: TextButton(
                onPressed:() async{
                  final credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: codeController.text);
                  await auth.signInWithCredential(credential);
                  Navigator.of(context).push(
                    _SignUpRoute(MyHomePage(users: users,)),
                  );
                },
                child:Container(
                    alignment:Alignment.center,
                    width:300,
                    height:50,
                    decoration:BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:Text('Tiếp theo',style:
                    TextStyle(
                      color:Colors.white,
                      fontSize:20,

                    )
                    )
                ),
              ),
            )
          ],
        )
    );
  }
}

Route _SignUpRoute (route) {
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
