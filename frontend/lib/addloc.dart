import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Validation extends StatefulWidget{
  const Validation({Key? key}) : super(key: key);
  @override
  _ValidationState createState() => _ValidationState();
}
class _ValidationState extends State<Validation>{
  double distanceInMeters = 0.0;
  double threshold = 100.0;
  String validate = 'Result';
  String og = "";
  String edited = "";
  Map addressInfoAfterEdit={};

  Future <String> ValidateAddress(og,edited) async{
    List<Location> extracted_address = await locationFromAddress(og);
    Location ex = extracted_address[0];
    List<Location> edited_address = await locationFromAddress(og);
    Location ed = edited_address[0];
    distanceInMeters = Geolocator.distanceBetween(ex.latitude,ex.longitude,ed.latitude,ed.longitude);
    validate = (distanceInMeters<threshold) ? 'Validated Successfully':'Rejected';
    setState(() {});
    return validate;
  }
  @override
  Widget build(BuildContext context) {

    addressInfoAfterEdit = ModalRoute.of(context)!.settings.arguments as Map;
    og=addressInfoAfterEdit['address'];
    edited=addressInfoAfterEdit['edited_address'];

    return Scaffold(
      appBar: AppBar(
          title:const Text('Second validtaion')
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              String status = await ValidateAddress(og,edited);
              if(status=="Validated Successfully") {
                print("1");
              } else {
                print('0');
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
