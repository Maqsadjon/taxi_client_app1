// import 'dart:js';

// import 'dart:ffi';
// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_client_app/AllScreens/userNote.dart';

import 'mainscreen.dart';


enum MobileVerificationState{

  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {

  static const String idScreen = "login";
 // GlobalKey<ScaffoldState> scaffoldKey;
  //LoginScreen({Key? key, required this.scaffoldKey}) : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  TextEditingController phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
   late String verificationId;
  bool showLoading = false;


  void signInWidthPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
   setState(() {
     showLoading = true;
   });
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if(authCredential.user !=null){
        Navigator.push(context,MaterialPageRoute(builder: (context) => MainScreen()));
      }

    }on FirebaseAuthException catch(e) {
setState(() {
  showLoading = false;
});
    _scaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }


  getMobileFormWidget(context){
    Size size = MediaQuery.of(context).size;
    return Column(
        children: [
      Container(
      width: double.infinity,
      height: size.height * 0.3,
          child: FittedBox(
              child: Image.asset("images/login_photo.png"),
                fit: BoxFit.cover,
              ),
      ),
          SizedBox(height: 15.0),

        Text(
          "Ro'yhatdan o'tish uchun mobil raqamingizni kiriting.",
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),

         SizedBox(height: 15.0),
        Container(
          padding: EdgeInsets.only(left: 5.0),
          height: 60.0,
          //padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 0.2,
                spreadRadius: 0.5,
                offset: Offset(0.7,0.7),
              ),
            ],
          ),
          child:  TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Mobile number",
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),

          ),

        ),
        SizedBox(height: 10.0),
        RaisedButton(
          color: Color(0xFF4ce4b1),
          textColor: Colors.white,
            child: Container(
              height: 60.0,
              child: Center(
                child: Text("Yuborish",
                style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                ),

              ),

            ),

            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),


            onPressed: () async {
              setState(() {
                showLoading = true;
              });
              await _auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoading = false;
                    });
                    // signInWidthPhoneAuthCredential(phoneAuthCredential);

                  } ,
                  verificationFailed: (verificationFailed) async {
                    setState(() {
                      showLoading = false;
                    });
                    _scaffoldKey.currentState!.showSnackBar(SnackBar(content:new Text(verificationFailed.message!)));
                  } ,
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      showLoading = false;
                      currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });

                  },
                  codeAutoRetrievalTimeout: (verificationId) async{

                  }
              );
            },
       ),
          SizedBox(height: 15.0),
          FlatButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(UserNote.idScreen),

            child: Text("Foydalanuvchi yo'riqnomasi bilan tanishish.",
              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
            ),

          )
      ],
    );
  }

  getOtpFormWidget(context){
        return Column(
          children: [
            Container(
              height: 180.0,
              //color: Color(0xff4ae2af),
              child: AppBar(
                backgroundColor: Color(0xff4ae2af),
                title: Text(
                  "Tasdiqlash kodini kiriting", style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold",),
                ),
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 50.0),
                      onPressed: () => Navigator.of(context).pushReplacementNamed(LoginScreen.idScreen),
                    ),
                     // title: Text("Sample"),
                      centerTitle: true,
                          ),
            ),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Tasdiqlash kodi",
                labelStyle: TextStyle(
                  fontSize: 14.0,fontFamily: "Brand-Bold",
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              color: Color(0xFF4ce4b1),
              textColor: Colors.white,
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text("Tasdiqlash",
                    style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                  ),
                ),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);

                signInWidthPhoneAuthCredential(phoneAuthCredential);
                },
              // child: Text("Kiritish"),
              // color: Color(0xFF0ce4b1),
              // textColor: Colors.white,
            ),

            Spacer(),
          ],

        );
  }

  var  _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: showLoading ? Center(child: CircularProgressIndicator(),) : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
            ? getMobileFormWidget(context)
            : getOtpFormWidget(context),
        padding: const EdgeInsets.all(0.0),
      ),

    );
  }
}

