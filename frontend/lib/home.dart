import 'package:flutter/material.dart';
import 'package:firebase_upload_example/request.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  var _extractedText = '';
  void extractOCRText(XFile? image) async {
    var data =
        await getData(Uri.parse('http://5eec-45-115-187-157.ngrok.io/'), image);
    var decodedData = await jsonDecode(jsonEncode(data));
    decodedData = json.decode(decodedData);
    _extractedText = decodedData['query'];
    print(_extractedText);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Get OCR"),
          onPressed: () async {
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
            extractOCRText(image);
            Future.delayed(Duration(seconds: 70), () {
              print("Executed after 60 seconds");
                 Navigator.pushNamed(context, '/selectAddress',
                arguments: {"address": _extractedText});
            });

         
          },
        ),
      ),
    );
  }
}
