import 'package:flutter/cupertino.dart';
import 'package:taxi_client_app/Models/address.dart';

class AppData extends ChangeNotifier
{
  var  pickUpLocation;

  void updatepickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;

    notifyListeners();
  }
}