import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_upload_example/api/firebase_api.dart';
import 'package:firebase_upload_example/home.dart';
//import 'package:firebase_upload_example/pdfviewer.dart';
import 'package:firebase_upload_example/api/backend_api.dart';
import 'package:firebase_upload_example/widget/button_widget.dart';
import 'package:firebase_upload_example/widget/proceed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import 'addloc.dart';
import 'edit_address.dart';
import 'gpsloc.dart';
import 'select_address.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Aadhar';

  @override
  Widget build(BuildContext context) => MaterialApp(
    routes: {
      '/selectAddress': (context) => SelectAddress(),
      //'/extractAddress': (context) => SelectAddress(address: addressFromOCR),
      '/editAddress': (context) => EditAddress(),
      '/validateCurrentAddress': (context) => GPSLoc(),
      '/sec_valid':(context) => Validation(),

    },
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.green),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UploadTask? task;
  File? file;
  // PDFDocument? document;
  // late final urlDownload;
  // bool _isLoading = true;
  double progress = 0.00;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ButtonWidget(
              //   text: 'Scan File',
              //   icon: Icons.camera,
              //   onClicked: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => MyHomePage(title: 'OCR',),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(height: 8),
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
   
              // SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
              // ListTile(
              //   title: Text('Load from URL'),
              //   onTap: () {
              //     print("EYYYYYYYYYYYYYYYYYYYYYYYYYY-1111");
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => PDFView(
              //                 data:
              //                     "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
              //               )),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  //   Future scanFile(ImageSource source) async {
  //     XFile? fileGallery = await ImagePicker.pickImage(source: source);

  //   if (result == null) return;
  //   final path = result.files.single.path!;

  //   setState(() => file = File(path));
  // }

  // void chooseImage(ImageSource source) async {}

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('Download-Link: $urlDownload');
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print('Download-Link: $file');
    // var res = await BackendApi.upload(urlDownload);
  }

   Widget buildUploadStatus(UploadTask task) {

    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          progress = snap.bytesTransferred / snap.totalBytes;
          print("#######################");
          print(progress);
          final percentage = (progress * 100).toStringAsFixed(2);

          return progress != 1.0
              ? Text(
                  '$percentage %',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : ButtonWidgetProceed(
                  text: 'Proceed',
                  icon: Icons.camera,
                  onClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          title: 'OCR',
                        ),
                      ),
                    );
                  },
                );
        } else {
          return Container();
        }
      },
    );
  }
}
