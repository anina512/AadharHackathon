
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';



class GPSLoc extends StatefulWidget{
  const GPSLoc({Key? key}) : super(key: key);
  @override
  _GPSLocState createState() => _GPSLocState();
}
class _GPSLocState extends State<GPSLoc> {
  String loc = "Please press Get Location";
  String add = '----';
  String dis = 'Distance b/w';
  double distanceInMeters = 0.0;
  double threshold = 100.0;
  String validate = 'Result';
  String a = "";
  Map currentAddressInfo={};


  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    // ignore: avoid_print
    print(placemarks);
    Placemark place = placemarks[0];
    add = '${place.street}, ${place.subLocality}, ${place.locality}, ${place
        .postalCode}, ${place.country}';
    setState(() {});
  }

  // ignore: non_constant_identifier_names
  Future <String> ValidateAddress(String a,Position position) async{
    List<Location> locations = await locationFromAddress(a);
    Location locat = locations[0];
    distanceInMeters = Geolocator.distanceBetween(position.latitude, position.longitude,locat.latitude,locat.longitude);
    validate = (distanceInMeters<threshold) ? 'Validated Successfully':'Rejected';
    setState(() {});
    return validate;
  }

  @override
  Widget build(BuildContext context) {
    currentAddressInfo = ModalRoute.of(context)!.settings.arguments as Map;
    a=currentAddressInfo['address'];

    return Scaffold(
      appBar: AppBar(
        title:const Text('Current Location')
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Coordinates Points',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text(loc, style: const TextStyle(color: Colors.black, fontSize: 16),),
            const SizedBox(height: 10,),
            const Text('ADDRESS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text(add),
            ElevatedButton(onPressed: () async {
              Position position = await _getGeoLocationPosition();
              loc = 'Lat: ${position.latitude} , Long: ${position.longitude}';
              GetAddressFromLatLong(position);
            }, child: const Text('Get Location')
            ),
            const SizedBox(height: 2),

            ElevatedButton(onPressed: () async {
              Position position = await _getGeoLocationPosition();
              String status = await ValidateAddress(a, position);
              if(status=="Validated Successfully") {
                Navigator.pushNamed(context, '/editAddress',arguments: {'address':a});

                //Navigator.pushNamed(context, '/sec_valid');
                print("1");
              } else {
                Navigator.pop(context);
                print("0");
              }

            }, child: const Text('Validate Address')
            ),
            const SizedBox(height: 2),
            Text(validate),

          ],
        ),
      ),
    );
  }
}


