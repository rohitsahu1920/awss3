import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s3/constants/constants.dart';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> paths = [];
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Doc Upload",
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: paths.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () async {
                    Constants.previewImg(paths[index],context,);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.upload),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Personal"),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String type = await Constants.showPicker(context);
          Constants.printValue("type :: $type");
          String path = await Constants.imagePicker(
              fromCamera: type == "camera" ? true : false);
          String croppedPath = await Constants.imageCropper(path: path);
          setState(() {
            paths.add(croppedPath);
          });

          Constants.printValue("Path :: $croppedPath");

          try {
            String url =
                "https://4urooft3g7.execute-api.eu-north-1.amazonaws.com/dev/fileuploads3-api/UploadedDoc.csv";

            Uint8List image = File(croppedPath).readAsBytesSync();

            final mimeType = lookupMimeType(croppedPath);
            Constants.printValue("Mime type :: $mimeType");

            var response = await http.put(
              Uri.parse(url),
              headers: {
                'Content-Type': "$mimeType",
                'Accept': "*/*",
                'Content-Length': File(croppedPath).lengthSync().toString(),
                'Connection': 'keep-alive',
              },
              body: File(croppedPath).readAsBytesSync(),
            );

            Constants.printValue("Response ${response.statusCode}");
          } catch (e) {
            Constants.printValue("First Error :: $e");
          }
        },
        label: const Text('Upload'),
        icon: const Icon(Icons.upload),
      ),
    );
  }
}
