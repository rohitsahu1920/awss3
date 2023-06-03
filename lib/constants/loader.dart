import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loader {
  static bool isLoading = false;

  static Future<void> startLoad(BuildContext context) async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return const Center(
          child: Wrap(
            children: <Widget>[
              SpinKitThreeBounce(
                color: Colors.orange,
              )
            ],
          ),
        );
      },);
    //await Future.delayed();
    //Navigator.pop(context);
  }

  static Future<void> stopLoader(BuildContext context) async{
    if (isLoading) {
      isLoading = false;
      Navigator.pop(context);
    }
  }
}
