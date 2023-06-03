import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:s3/Controller.dart';
import 'package:s3/constants/constants.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';

// ignore: depend_on_referenced_packages
import 'package:open_file/open_file.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class Model {
  String path;
  String size;

  Model(this.path, this.size);
}

class _HomePageState extends State<HomePage> {
  List<Model> paths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Doc Upload",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Comment Icon',
            onPressed: () async {
              try {
                // String path = await ExtStorage.getExternalStoragePublicDirectory(
                //     ExtStorage.DIRECTORY_DOWNLOADS);
                // final dir = await getExternalStorageDirectory();
                // final dirTwo = await getApplicationDocumentsDirectory();
                // final dirThree = await getTemporaryDirectory();
                // final status = await Permission.storage.request();
                // String path  = "/storage/emulated/0/";
                // bool x = await File(path).exists();
                // Constants.printValue("value $x :: ${dirThree.path} :: ${dir!.path} :: ${dirTwo.path}");

                final status = await Permission.storage.request();
                EasyLoading.show(
                  status: 'loading...',
                  dismissOnTap: false,
                );
                if (status.isGranted) {
                  // final dir =
                  //await getApplicationDocumentsDirectory();
                  String value = await Controller.singlePdfApi(paths: paths);

                  final filename = value.substring(value.lastIndexOf("/") + 1);
                  var request = await HttpClient().getUrl(Uri.parse(value));
                  var response = await request.close();
                  var bytes =
                      await consolidateHttpClientResponseBytes(response);
                  String dir = (await getTemporaryDirectory()).path;
                  File file = File('$dir/$filename');
                  await file.writeAsBytes(bytes);
                  EasyLoading.dismiss();
                  Constants.printValue("Path :: $file");
                  Constants.printValue("Path :: ${file.path}");
                  final params =
                      SaveFileDialogParams(sourceFilePath: file.path);
                  final filePath =
                      await FlutterFileDialog.saveFile(params: params);
                  OpenFile.open(filePath);
                }
              } catch (e) {
                Constants.printValue("Download Error :: $e");
              }
            },
          ),
        ],
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
                      paths[index].path,
                      context,
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle_outlined),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("Img_$index"),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(paths[index].size),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            paths.removeAt(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
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
          EasyLoading.show(
            status: 'loading...',
            dismissOnTap: false,
          );

          bool value =
              await Controller.putMethodUpload(croppedPath: croppedPath);
          Constants.printValue("After Upload :: $value");
          if (value) {
            Model value =
                await Controller.compressApi(croppedPath: croppedPath);
            Constants.printValue("After Compressed :: $value");

            if (value.path.isNotEmpty) {
              setState(() {
                paths.add(value);
              });
            }
          }
          EasyLoading.dismiss();
        },
        label: const Text('Upload'),
        icon: const Icon(Icons.upload),
      ),
    );
  }
}
