import 'dart:io';

import 'package:flutter/material.dart';
import 'package:s3/constants/constants.dart';

// ignore: depend_on_referenced_packages
import 'package:simple_s3/simple_s3.dart';
// ignore: depend_on_referenced_packages
import 'package:aws_s3_upload/aws_s3_upload.dart';
// ignore: depend_on_referenced_packages
import 'package:minio/minio.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> paths = [];
  final SimpleS3 _simpleS3 = SimpleS3();

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
                  onTap: () async {},
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: const [
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

          try{
            String results = await _simpleS3.uploadFile(
                File(path),
                fileName: "Example.jpg",
                debugLog: true,
                "upload",
                "ap-south-1:e3eed97f-515f-4537-a26b-9978b01fc6ac",
                accessControl: S3AccessControl.publicReadWrite,
                AWSRegions.apSouth1);

            Constants.printValue("First Results :: $results");

          }catch(e){
            Constants.printValue("First Error :: $e");
          }




          // try{
          //   final minio = Minio(
          //       endPoint: 's3.amazonaws.com',
          //       accessKey: 'AKIAZDH6KTHUZC4S2VXH',
          //       secretKey: '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',
          //       region: 'ap-south-1'
          //   );
          //
          //   final stream = await minio.getObject('rohitsahu', path);
          //
          //   // Get object length
          //   Constants.printValue("Get object length :: ${stream.contentLength}");
          //
          //   // Write object data stream to file
          //   await stream.pipe(File(path).openWrite());
          // }catch(e){
          //   Constants.printValue("Second Error :: $e");
          // }




          // try{
          //   String? result = await AwsS3.uploadFile(
          //     accessKey: "AKIAZDH6KTHUZC4S2VXH",
          //     secretKey: "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",
          //     file: File(path),
          //     bucket: "rohitsahu",
          //     region: "ap-south-1",
          //   );
          //
          //   Constants.printValue("Third Result :: $result");
          // }catch(e){
          //   Constants.printValue("Third Error :: $e");
          // }





        },
        label: const Text('Upload'),
        icon: const Icon(Icons.upload),
      ),
    );
  }
}
