import 'dart:io';

import 'package:flutter/material.dart';
import 'package:s3/Controller.dart';
import 'package:s3/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> paths = [];

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
                    Constants.previewImg(
                      paths[index],
                      context,
                    );
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


          Constants.printValue("Cropped Path :: $croppedPath");


          bool value = await Controller.putMethodUpload(croppedPath: croppedPath);
          Constants.printValue("After Upload :: $value");
          if(value){
            String value = await Controller.compressApi(croppedPath: croppedPath);
            Constants.printValue("After Compressed :: $value");

            if(value.isNotEmpty){
              setState(() {
                paths.add(value);
              });
            }
          }
        },
        label: const Text('Upload'),
        icon: const Icon(Icons.upload),
      ),
    );
  }
}
