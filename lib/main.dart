import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taxi_client_app/AllScreens/animatedSplashScreen.dart';
import 'package:taxi_client_app/AllScreens/userNote.dart';
import 'AllScreens/loginScreen.dart';
import 'AllScreens/mainscreen.dart';
import 'AllScreens/registerationScreen.dart';
import 'DataHandler/appData.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppData()),
  ], child: MyApp()));
  //runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xFF4ce4b1), // this one for android
            // statusBarBrightness: Brightness.light// this one for iOS
        ),);
    return ChangeNotifierProvider(
      create:(context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Client App',
        theme: ThemeData(

          primarySwatch: Colors.teal,
        ),
        initialRoute: AnimatedSplashScreen.idScreen,
        routes:
        {
          RegisterationScreen.idScreen: (context) => RegisterationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          AnimatedSplashScreen.idScreen:(context) => AnimatedSplashScreen(),
          UserNote.idScreen:(context) => UserNote(),


        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}