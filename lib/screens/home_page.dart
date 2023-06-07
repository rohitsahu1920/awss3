import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:s3/controller.dart';
import 'package:s3/constants/constants.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';

// ignore: depend_on_referenced_packages
import 'package:open_file/open_file.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:s3/constants/loader.dart';

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
        backgroundColor: const Color(0xfff58220),
        title: const Text(
          "Doc Upload",
        ),
        actions: [
          InkWell(
            onTap: () async {
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
                if (!mounted) return;
                Loader.startLoad(context);
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
                  if (!mounted) return;
                  bool uploadRes =
                      await Controller.putMethodUpload(croppedPath: file.path);
                  if (uploadRes) {
                    Model model =
                        await Controller.compressApi(croppedPath: file.path);
                    final filename = model.path.substring(model.path.lastIndexOf("/") + 1);
                    var request = await HttpClient().getUrl(Uri.parse(model.path));
                    var response = await request.close();
                    var bytes =
                    await consolidateHttpClientResponseBytes(response);
                    String dir = (await getTemporaryDirectory()).path;
                    File fileTwo = File('$dir/$filename');
                    await fileTwo.writeAsBytes(bytes);
                    Constants.printValue("Path :: $fileTwo");
                    Constants.printValue("Path :: ${fileTwo.path}");
                    final params =
                        SaveFileDialogParams(sourceFilePath: fileTwo.path);
                    String? path =
                        await FlutterFileDialog.saveFile(params: params);
                    //paths.clear();
                    Constants.printValue("Path :: $path");
                    OpenFile.open(path);
                    setState(() {});
                  }
                  if(!mounted) return;
                  Loader.stopLoader(context);
                }
              } catch (e) {
                Constants.printValue("Download Error :: $e");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Text("PDF"),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.cloud_download_outlined,
                        color: Color(0xfff58220)),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          )
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
                        Text("${paths[index].size} KB"),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            paths.removeAt(index);
                            setState(() {});
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
          if (!mounted) return;
          Loader.startLoad(context);

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
          if (!mounted) return;
          Loader.stopLoader(context);
        },
        backgroundColor: const Color(0xfff58220),
        label: const Text('Upload'),
        icon: const Icon(Icons.upload),
      ),
    );
  }
}
