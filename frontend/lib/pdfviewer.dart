import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_upload_example/api/firebase_api.dart';
import 'package:firebase_upload_example/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:path/path.dart';

class PDFView extends StatefulWidget {
  final String data;
  const PDFView({ Key? key, required this.data }) : super(key: key);
  

  @override
  _PDFViewState createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFViewer> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 36),
            
              ListTile(
                title: Text('Load from URL'),
                onTap: () {
                    print("EYYYYYYYYYYYYYYYYYYYYYYYYYY");
                },
              ),
    

            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('FlutterPluginPDFViewer'),
        ),
        body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                  //uncomment below line to preload all pages
                  // lazyLoad: false,
                  // uncomment below line to scroll vertically
                  // scrollDirection: Axis.vertical,

                  //uncomment below code to replace bottom navigation with your own
                  /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
                ),
        ),
      ),
    );
  }
}
