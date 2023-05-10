// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:image_cropper/image_cropper.dart';

class Constants {
  static Future<String> imagePicker({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    return image!.path;
  }

  static void printValue(String value) {
    if (kDebugMode) {
      print(value);
    }
  }

  static Future<String> showPicker(BuildContext context) async {
    String type = "";
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  type = "gallery";
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  type = "camera";
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
    return type;
  }

  static Future<String> imageCropper({required String path}) async {
    var croppedFile = await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.jpg,
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Image',
        )
      ],
    );

    return croppedFile!.path;
  }
}
