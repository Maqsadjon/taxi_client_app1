import 'package:flutter/cupertino.dart';

class Address
{
     final String placeFormattedAddress;
     late  String placeName;
     final String placeId;
     final double latitude;
     final double longitude;

   // Address({required this.placeFormattedAddress, required this.placeName, required this.placeId, required this.longitude, required this.latitude});
     Address({Key? key, required this.latitude, required this.placeFormattedAddress, required this.placeName, required this.placeId, required this.longitude, });

}