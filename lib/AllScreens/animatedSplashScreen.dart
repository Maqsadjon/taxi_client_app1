import 'dart:async';

//import 'package:flutter_spleshscreen/Constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/AllScreens/loginScreen.dart';

class AnimatedSplashScreen extends StatefulWidget {
  static const String idScreen = "animated";
  @override

  SplashScreenState createState() => new SplashScreenState();
}


class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(LoginScreen.idScreen);
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4ce4b1),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
            child: Column(
              children: [
                SizedBox(height: 100.0,),
                Image(
                  image: AssetImage("images/logo_asosiy.png"),
                  width: 390.0,
                  height: 250.0,
                  //alignment: Alignment.bottomCenter,
                ),
               Padding(
                   padding: EdgeInsets.only(top: 130.0,),
                   child: Image(
                   image: AssetImage("images/icon_past_tepa.png"),
                    width: 390.0,
                    height: 250.0,
                     alignment: Alignment.bottomCenter,
          ),
               )


              ],
            ),
          ),
        )
    );
  }
}