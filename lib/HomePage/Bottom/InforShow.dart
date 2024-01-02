import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../model/UserHobbies.dart';
import '../../model/Users.dart';


class InforShow extends StatelessWidget{
  SwipeItem? users;
  InforShow({this.users});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(

        child: ListView(
          children: [
            //
            //Button scroll down
            ScrollDown(),

            //
            //Name and age
            Name_age(users: users),

            //
            //Sex
            Sex(users: users),

            //
            //Location
            // Location(),
            //
            //Thanh gach ngang
            Container(
              margin:EdgeInsets.only(top:10),
              decoration:BoxDecoration(
                border:Border.all(width:0.5,style:BorderStyle.solid)
              ),
              child:null,
            ),

            //
            //Giới thiệu bản thân
           Infor(users: users),

            //
            //Thanh gach ngang
            Container(
              margin:EdgeInsets.only(top:10),
              decoration:BoxDecoration(
                  border:Border.all(width:0.5,style:BorderStyle.solid)
              ),
              child:null,
            ),

            //
            //Sở thích của bản thân
            Like(users: users),
          ],
        ),
      ),

    );
  }
}

class ScrollDown extends StatelessWidget{
  const ScrollDown({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
        width:100,
        decoration:BoxDecoration(
            color:Colors.redAccent
        ),
        child:IconButton(
          onPressed:()=>{
            Navigator.pop(context)
          },
          icon:Icon(Icons.arrow_circle_down,color:Colors.white),
        )
    );
  }
}

class Name_age extends StatelessWidget{
  SwipeItem? users;
  Name_age({this.users});

  @override
  Widget build(BuildContext context){
    return Container(
      margin:EdgeInsets.only(left:20,top:30),
      child:Row(
          children:[
            Container(

                child:Text('${users!.content.name}',style:TextStyle(fontWeight:FontWeight.bold,fontSize:30))
            ),
            Container(
                margin:EdgeInsets.only(left:10),
                child:Text('${users!.content.age}',style:TextStyle(fontSize:30))
            ),
          ]
      ),
    );
  }
}

class Sex extends StatelessWidget{
  SwipeItem? users;
  Sex({this.users});

  @override
  Widget build(BuildContext context){
    return Container(
        margin:EdgeInsets.only(left:20),
        child:Row(
            children:[
              Icon(Icons.person),
              Text('${users!.content.sex}'),
            ]
        )
    );
  }
}
// class Location extends StatelessWidget{
//   const Location({super.key});
//
//   @override
//   Widget build(BuildContext context){
//     return Container(
//         margin:EdgeInsets.only(left:20),
//       child:Row(
//             children:[
//               Icon(Icons.location_on),
//               Text('Sống tại TP Hồ Chí Minh'),
//             ]
//         )
//     );
//   }
// }

class Infor extends StatelessWidget{
  SwipeItem? users;
  Infor ({this.users});

  @override
  Widget build(BuildContext context){
    return  Container(
        margin:EdgeInsets.only(left:20,top:10),
        child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Container(
                  child:Text('Giới thiệu bản thân',style:TextStyle(fontWeight:FontWeight.bold,fontSize:15))
              ),
              Container(
                  margin:EdgeInsets.only(top:10),
                  width:300,
                  child:Wrap(
                      children:[
                        users!.content.description == null ?
                        Text('Hãy nhập giới thiệu của bản thân ở mục cá nhân')
                        :
                        Text('${users!.content.description}')
                      ]
                  )
              )
            ]
        )
    );
  }
}


class Like extends StatelessWidget {
  SwipeItem? users;
  Like({this.users});
  List<UserHobbies> hobbies = [];
  List<UserHobbies> changeHobbies(){
    // usersList.forEach((hobby) {
    //   hobbies.add(hobby.hobbies);
    // });
    for(int i = 0 ; i < users!.content.listHobbies.length ; i++){
      hobbies.add(UserHobbies(hobbies: users!.content.listHobbies[i]) );
    }
    print(hobbies);
    return hobbies;
  }

  @override
  Widget build(BuildContext context){
    // changeHobbies();
    hobbies = users!.content.listHobbies ;
    return Container(
        margin:EdgeInsets.only(left:20,top:10),
        child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Container(
                  child:Text('Sở thích của tôi',style:TextStyle(fontWeight:FontWeight.bold,fontSize:15))
              ),
              Container(

                  width:300,
                  child:Wrap(
                    children: (hobbies).map((hobby){
                      return Container(
                                margin:EdgeInsets.only(top:10,right:10),
                                padding:EdgeInsets.all(10),
                                decoration:BoxDecoration(
                                  border:Border.all(width:1,style:BorderStyle.solid),
                                  borderRadius:BorderRadius.circular(20),
                                ),
                                child:Text(
                                    // '${hobby!.hobbies}'
                                  '${hobby.hobbies}'
                                )
                            );
                    }).toList(),
                      // children:[
                      //   Container(
                      //       margin:EdgeInsets.only(top:10,right:10),
                      //       padding:EdgeInsets.all(10),
                      //       decoration:BoxDecoration(
                      //         border:Border.all(width:0.5,style:BorderStyle.solid),
                      //         borderRadius:BorderRadius.circular(20),
                      //       ),
                      //       child:Text(
                      //           'Đá banh'
                      //       )
                      //   ),
                      //   Container(
                      //       margin:EdgeInsets.only(top:10,right:10),
                      //       padding:EdgeInsets.all(10),
                      //       decoration:BoxDecoration(
                      //         border:Border.all(width:0.5,style:BorderStyle.solid),
                      //         borderRadius:BorderRadius.circular(20),
                      //       ),
                      //       child:Text(
                      //           'Chơi Liên minh huyền thoại'
                      //       )
                      //   ),
                      //   Container(
                      //       margin:EdgeInsets.only(top:10,right:10),
                      //       padding:EdgeInsets.all(10),
                      //       decoration:BoxDecoration(
                      //         border:Border.all(width:0.5,style:BorderStyle.solid),
                      //         borderRadius:BorderRadius.circular(20),
                      //       ),
                      //       child:Text(
                      //           'Xem anime thâu đêm suốt sáng'
                      //       )
                      //   )
                      // ]
                  )
              )
            ]
        )
    );
  }
}

