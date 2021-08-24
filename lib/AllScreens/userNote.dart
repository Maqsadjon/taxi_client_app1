//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:taxi_client_app/AllScreens/loginScreen.dart';

class UserNote extends StatefulWidget {
  static const String idScreen = "usernote";
  // const UserNote({Key? key}) : super(key: key);

  @override
  _UserNoteState createState() => _UserNoteState();
}

class _UserNoteState extends State<UserNote> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
      Container(
      height: size.height * 1,
      //color: Color(0xff4ae2af),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0.6,
              spreadRadius: 0.5,
              offset: Offset(0.7,0.7),
            ),
          ],
        ),
        child:  Text("ASSALOMU ALAYKUM",
          style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold",color: Colors.grey,),
        ),
    ),
    ],
    );
  }
}
