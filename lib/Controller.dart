import 'dart:convert';
import 'dart:io';

import 'constants/constants.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

import 'model/compress_response.dart';

class Controller {
  static Future<bool> putMethodUpload({
    required String croppedPath,
  }) async {
    try {
      File fileTwo = File(croppedPath);
      String fileName = fileTwo.path.split('/').last;
      Constants.printValue("File Name :: $fileName");

      String url =
          "https://4urooft3g7.execute-api.eu-north-1.amazonaws.com/dev/fileuploads3-api/$fileName";

      final mimeType = lookupMimeType(croppedPath);
      Constants.printValue("Mime type :: $mimeType");

      Constants.printValue("APi Calling");
      Constants.printValue("Url :: $url");
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
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Constants.printValue("First Error :: $e");
      return false;
    }
  }

  static Future<String> compressApi({
    required String croppedPath,
  }) async {
    try {
      File fileTwo = File(croppedPath);
      String fileName = fileTwo.path.split('/').last;
      Constants.printValue("File Name :: $fileName");

      String url =
          "https://uatcompressfile.takemyinsurance.com/api/IMGCOMPRESS_CompressFile";

      Map<String, dynamic> data = {
        "vAppSubVersion": "203",
        "vAppVersion": "2.3.14",
        "vCode": "PROBITAS",
        "vSTICKER": "BROWSER",
        "vDeviceDetails":
            "AID:5487863f4b994ba9~UID:~MOD:Android SDK built for x86~MFG:Google~SRN:unknown~BRA:google~IME:~SIM:GSM",
        "vDeviceUID": "0",
        "vLatitude": "0",
        "vLogitude": "0",
        "vRequestedService": "IMGCOMPRESS_CompressFile",
        "vExtraParam1": "nvExtraParam1",
        "vExtraParam2": "nvExtraParam2",
        "vProvider": "not set",
        "vAccuracy": "0.0",
        "vSpeed": "0.0",
        "vDirection": "0.0",
        "vAltitude": "0.0",
        "vLocationAge": 1593875240422,
        "vGPSTimeStamp": "0",
        "vPassengerID": "0",
        "vUserID": "mehulshah169@hotmail.com",
        "vUserPassword": "998ac8c07701d000079140c8ea4e9949",
        "vDeviceRepetativeValue":
            "BLD:QSR1.190920.001~AOS:10 29~CHG:not charging~BAT:100.0~TMZ:GMT+05:30 Asia/Calcutta~TIM:Jul 4, 2020 8:37:20 PM~EML:~DEN:420~ORI:PORTRAIT~HGH:4.0~WID:2.0~DIG:4.99~SSW:411~OSW:411",
        "vPassengerMobileNo": "",
        "vPostedData": {
          "FileNameURL":
              "https://fileuploads3-api.s3.eu-north-1.amazonaws.com/$fileName"
        },
      };

      final mimeType = lookupMimeType(croppedPath);
      Constants.printValue("Mime type :: $mimeType");

      Constants.printValue("APi Calling");
      Constants.printValue("Url :: $url");
      Constants.printValue("Req :: $url");
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': "application/json",
          'Accept': "*/*",
          'Connection': 'keep-alive',
        },
        body: jsonEncode(data),
      );

      Constants.printValue("Response ${response.statusCode}");
      Constants.printValue("Response ${response.body}");

      CompressedModel compressedModel = CompressedModel.fromJson(jsonDecode(response.body));
      Constants.printValue("Response after ::  ${compressedModel.lAYERRESP!.postedData!.fileNameURL}");
      if (response.statusCode == 200) {
        return compressedModel.lAYERRESP!.postedData!.fileNameURL!;
      } else {
        return "";
      }
    } catch (e) {
      Constants.printValue("Second Error :: $e");
      return "";
    }
  }
}
