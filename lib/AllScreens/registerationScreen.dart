import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi_client_app/AllScreens/AllWidgets/progressDialog.dart';
import 'package:taxi_client_app/AllScreens/loginScreen.dart';
import 'package:taxi_client_app/AllScreens/mainscreen.dart';
import 'package:taxi_client_app/main.dart';

class RegisterationScreen extends StatelessWidget
{

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  static const String idScreen = "register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20.20,),
                Image(
                  image: AssetImage("images/taxi_logos.png"),
                  width: 390.0,
                  height: 250.0,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 1.0,),
                Text(
                  "Register is Taxi Client App",
                  style: TextStyle(fontSize: 24.0, fontFamily:"Brand Bold"),
                  textAlign: TextAlign.center,
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [

                      SizedBox(height: 1.0,),
                      TextField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),

                        style: TextStyle(fontSize: 14.0),

                      ),

                      SizedBox(height: 1.0,),
                      TextField(
                        controller:emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),

                        style: TextStyle(fontSize: 14.0),

                      ),

                      SizedBox(height: 1.0,),
                      TextField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone number",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),

                        style: TextStyle(fontSize: 14.0),

                      ),

                      SizedBox(height: 1.0,),
                      TextField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),

                        style: TextStyle(fontSize: 14.0),

                      ),

                      SizedBox(height: 18.0,),
                      RaisedButton(
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),

                          ),
                        ),

                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: ()
                        {

                          if(nameTextEditingController.text.length <3)
                            {
                              displayToastMessage("name must be atleast 3 characters",  context);
                            }
                          else if(!emailTextEditingController.text.contains("@"))
                        {
                        displayToastMessage("email do not correct",  context);
                        }
                          else if(phoneTextEditingController.text.length <12)
                          {
                            displayToastMessage("Phone number must be 12 characters", context);
                          }
                          else if(passwordTextEditingController.text.length <7)
                          {
                            displayToastMessage("Password must be 6 characters", context);
                          }
                          else
                          {
                          registerNewUser(context);

                        }

                        },

                      ),
                    ],
                  ),


                ),

                FlatButton(
                  onPressed: ()
                  {
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);

                  },
                  child: Text(
                      "Already have an Account? Login"
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Ro'yhatdan o'tilmoqda...",);
        }

    );
    final firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text, password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error:" + errMsg.toString(), context);
    })).user;

    if(firebaseUser !=null) //user created
      {
        //save user database info

      Map userDataMap ={
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Tabriklayman account yaratildi", context);
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    }
     else
       {
         Navigator.pop(context);
         //Error occured - display error msg
         displayToastMessage("New User account has not been created", context);
       }
  }

}
displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);

}