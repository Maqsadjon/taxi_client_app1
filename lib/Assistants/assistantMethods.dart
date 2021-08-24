import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:taxi_client_app/Assistants/requestAssistant.dart';
import 'package:taxi_client_app/DataHandler/appData.dart';
import 'package:taxi_client_app/Models/address.dart';



class AssistantMethods
{

     static Future<String> searchCoordinateAddress(Position position, context) async
  {
      late String plceAddress = "";
      late String st1,st2,st3,st4;

      String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$position.latitude,$position.longitude&key=AIzaSyB91E_M7LsGnr1pnEnXhAapI6G7EyEBc6Q";

      var response = await RequestAssistant.getRequest(url);
      if(response != "failed")
      {
       // plceAddress = response["results"][0]["formatted_address"];
        st1 = response["results"][0]["address_components"][3]["long_name"];
        st2 = response["results"][0]["address_components"][4]["long_name"];
        st3 = response["results"][0]["address_components"][5]["long_name"];
        st4 = response["results"][0]["address_components"][6]["long_name"];

        plceAddress = st1 +", "+ st2 +", "+ st3 + ", " +st4;

        Address userPickupAddress = new Address(placeId: '-', placeFormattedAddress: '-', latitude: position.latitude, longitude: position.longitude, placeName: '');
        //userPickupAddress.longitude = position.latitude;
        //userPickupAddress.latitude = position.longitude;
        userPickupAddress.placeName = plceAddress;

        Provider.of<AppData>(context, listen: false).updatepickUpLocationAddress(userPickupAddress);
      }
      return plceAddress;
  }
}