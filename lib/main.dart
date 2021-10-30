import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_address_ext/select_address.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String addressFromOCR ="""
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. 
The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 
'Content here, content here', making it look like readable English. 416, Navrang Arcade, Gokhale Road, Nxt Alok Hotel, Thane (west). 
Many desktop publishing packages and web page editors now use Lorem 
Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
 Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).""";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/selectAddress': (context) => SelectAddress(address: addressFromOCR),
        '/extractAddress': (context) => SelectAddress(address: addressFromOCR),
      },
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OCR address'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 40
            ),
            child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {

                    },
                    color: Colors.redAccent,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Text(
                      "Extract address from text", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,

                    ),),

                  ),
                  const SizedBox(width: 50,),
                  const Text("OR", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,

                  ),),
                  MaterialButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, "/selectAddress");
                    },
                    color: Colors.redAccent,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Text(
                      "Select Address from text", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,

                    ),),

                  )


                ]
            )
          //SelectAddress(address: addressFromOCR),
        )
    );



  }

}




