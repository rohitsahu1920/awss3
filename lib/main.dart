// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:s3/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadClass{
  static void callback(String id, DownloadTaskStatus status, int progress){

  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  //await FlutterDownloader.registerCallback(DownloadClass.callback);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

