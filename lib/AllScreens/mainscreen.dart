import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi_client_app/AllScreens/AllWidgets/Divider.dart';
import 'package:taxi_client_app/AllScreens/loginScreen.dart';
import 'package:taxi_client_app/AllScreens/searchScreen.dart';
import 'package:taxi_client_app/Assistants/assistantMethods.dart';
import 'package:taxi_client_app/DataHandler/appData.dart';

class MainScreen extends StatefulWidget
{
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  late Position currentPosition;
  late String address;
  var geolocator = Geolocator();
  double bottomPaddingOfMap =0;
  final _auth = FirebaseAuth.instance;

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition,zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your address::"+ address);
  }

  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.582747981152565, 70.91653389520042),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    //Provider.of<AppData>(context, listen: false).pickUpLocation;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
title: Text("MainScreen"),
         backgroundColor: Color(0xFF4ce4b1),
      ),
        drawer: Container(
          color: Colors.white,
          width: 255.0,
          child: Drawer(
            child: ListView(
              children: [
                //Drawer header
                Container(
                  height: 165.0,
                  child: DrawerHeader(
                    decoration:BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset("images/user_icon.png", height: 65.0,width: 65.0,),
                        SizedBox(width: 16.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Profile name", style: TextStyle(fontSize: 16.0,fontFamily: "Brand-Bold"),),
                            SizedBox(height: 6.0,),
                            Text("Profilga kirish"),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                DividerWidget(),
                SizedBox(height: 12.0,),

                //Drawer Body Controllers
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Tarih",style: TextStyle(fontSize: 15.0,fontFamily: ""),),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profilga kirish",style: TextStyle(fontSize: 15.0,fontFamily: ""),),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Chiqish",style: TextStyle(fontSize: 15.0,fontFamily: ""),),
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                  },
                ),

              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller)
              {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController =controller;

                setState(() {
                  bottomPaddingOfMap = 300.0;
                });

                locatePosition();

              },
            ),
            //HamburgerButton
            Positioned(
              top: 45.0,
              left: 22.0,
              child: GestureDetector(
                onTap: ()
                {
                scaffoldKey.currentState!.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7, 0.7,
                        ),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.menu, color: Colors.black,),
                    radius: 20.0,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0),
                      Text("Hi there", style: TextStyle(fontSize: 12.0),),
                      Text("Where to?", style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),),

                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: ()
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));

                        },
                        child: Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7,0.7),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding:  EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.teal,),
                              SizedBox(width: 10.0,),
                              Text("Search drop off")
                            ],
                          ),
                        ),

                      ),
                      ),

                      SizedBox(height: 24.0,),
                      Row(
                        children: [
                          Icon(Icons.home,color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  Provider.of<AppData>(context).pickUpLocation !=null ?
                                        Provider.of<AppData>(context).pickUpLocation.placeName
                                    :
                                     "Add Home"
                              ),
                              SizedBox(height: 4.0,),
                              Text("Your living home adress",style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                            ],
                          ),

                        ],
                      ),

                      SizedBox(height: 10.0,),
                      DividerWidget(),
                      SizedBox(height: 16.0,),
                      Row(
                        children: [
                          Icon(Icons.work,color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(height: 4.0,),
                              Text("Your Office adress",style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],

        ),
    );

  }
}
