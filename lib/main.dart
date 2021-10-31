import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gps_mod/addloc.dart';
import 'package:gps_mod/gpsloc.dart';
import 'package:gps_mod/addloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: GPSLoc(),
      routes:{
        '/sec_valid':(context) => Validation(),
      }
    );
  }
}
