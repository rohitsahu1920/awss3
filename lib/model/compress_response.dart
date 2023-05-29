class CompressedModel {
  final LAYERDM? lAYERDM;
  final LAYERAUTH? lAYERAUTH;
  final LAYERLIC? lAYERLIC;
  final LAYERRESP? lAYERRESP;

  CompressedModel({
    this.lAYERDM,
    this.lAYERAUTH,
    this.lAYERLIC,
    this.lAYERRESP,
  });

  CompressedModel.fromJson(Map<String, dynamic> json)
      : lAYERDM = (json['LAYER_DM'] as Map<String,dynamic>?) != null ? LAYERDM.fromJson(json['LAYER_DM'] as Map<String,dynamic>) : null,
        lAYERAUTH = (json['LAYER_AUTH'] as Map<String,dynamic>?) != null ? LAYERAUTH.fromJson(json['LAYER_AUTH'] as Map<String,dynamic>) : null,
        lAYERLIC = (json['LAYER_LIC'] as Map<String,dynamic>?) != null ? LAYERLIC.fromJson(json['LAYER_LIC'] as Map<String,dynamic>) : null,
        lAYERRESP = (json['LAYER_RESP'] as Map<String,dynamic>?) != null ? LAYERRESP.fromJson(json['LAYER_RESP'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'LAYER_DM' : lAYERDM?.toJson(),
    'LAYER_AUTH' : lAYERAUTH?.toJson(),
    'LAYER_LIC' : lAYERLIC?.toJson(),
    'LAYER_RESP' : lAYERRESP?.toJson()
  };
}

class LAYERDM {
  final String? layerResponse;
  final String? layerName;
  final String? layerSuccessFailure;

  LAYERDM({
    this.layerResponse,
    this.layerName,
    this.layerSuccessFailure,
  });

  LAYERDM.fromJson(Map<String, dynamic> json)
      : layerResponse = json['Layer_Response'] as String?,
        layerName = json['Layer_Name'] as String?,
        layerSuccessFailure = json['Layer_SuccessFailure'] as String?;

  Map<String, dynamic> toJson() => {
    'Layer_Response' : layerResponse,
    'Layer_Name' : layerName,
    'Layer_SuccessFailure' : layerSuccessFailure
  };
}

class LAYERAUTH {
  final String? layerResponse;
  final String? layerName;
  final String? layerSuccessFailure;

  LAYERAUTH({
    this.layerResponse,
    this.layerName,
    this.layerSuccessFailure,
  });

  LAYERAUTH.fromJson(Map<String, dynamic> json)
      : layerResponse = json['Layer_Response'] as String?,
        layerName = json['Layer_Name'] as String?,
        layerSuccessFailure = json['Layer_SuccessFailure'] as String?;

  Map<String, dynamic> toJson() => {
    'Layer_Response' : layerResponse,
    'Layer_Name' : layerName,
    'Layer_SuccessFailure' : layerSuccessFailure
  };
}

class LAYERLIC {
  final String? layerResponse;
  final String? layerName;
  final String? layerSuccessFailure;

  LAYERLIC({
    this.layerResponse,
    this.layerName,
    this.layerSuccessFailure,
  });

  LAYERLIC.fromJson(Map<String, dynamic> json)
      : layerResponse = json['Layer_Response'] as String?,
        layerName = json['Layer_Name'] as String?,
        layerSuccessFailure = json['Layer_SuccessFailure'] as String?;

  Map<String, dynamic> toJson() => {
    'Layer_Response' : layerResponse,
    'Layer_Name' : layerName,
    'Layer_SuccessFailure' : layerSuccessFailure
  };
}

class LAYERRESP {
  final PostedData? postedData;
  final LayerResponse? layerResponse;
  final LayerName? layerName;
  final String? layerSuccessFailure;

  LAYERRESP({
    this.postedData,
    this.layerResponse,
    this.layerName,
    this.layerSuccessFailure,
  });

  LAYERRESP.fromJson(Map<String, dynamic> json)
      : postedData = (json['PostedData'] as Map<String,dynamic>?) != null ? PostedData.fromJson(json['PostedData'] as Map<String,dynamic>) : null,
        layerResponse = (json['Layer_Response'] as Map<String,dynamic>?) != null ? LayerResponse.fromJson(json['Layer_Response'] as Map<String,dynamic>) : null,
        layerName = (json['Layer_Name'] as Map<String,dynamic>?) != null ? LayerName.fromJson(json['Layer_Name'] as Map<String,dynamic>) : null,
        layerSuccessFailure = json['Layer_SuccessFailure'] as String?;

  Map<String, dynamic> toJson() => {
    'PostedData' : postedData?.toJson(),
    'Layer_Response' : layerResponse?.toJson(),
    'Layer_Name' : layerName?.toJson(),
    'Layer_SuccessFailure' : layerSuccessFailure
  };
}

class PostedData {
  final String? fileNameURL;

  PostedData({
    this.fileNameURL,
  });

  PostedData.fromJson(Map<String, dynamic> json)
      : fileNameURL = json['FileNameURL'] as String?;

  Map<String, dynamic> toJson() => {
    'FileNameURL' : fileNameURL
  };
}

class LayerResponse {
  final String? layerResponseSTATUSSuccessFail;
  final String? layerResponseMessage;
  final LayerResponseReturnParams? layerResponseReturnParams;

  LayerResponse({
    this.layerResponseSTATUSSuccessFail,
    this.layerResponseMessage,
    this.layerResponseReturnParams,
  });

  LayerResponse.fromJson(Map<String, dynamic> json)
      : layerResponseSTATUSSuccessFail = json['Layer_Response_STATUS_Success_Fail'] as String?,
        layerResponseMessage = json['Layer_Response_Message'] as String?,
        layerResponseReturnParams = (json['Layer_Response_Return_Params'] as Map<String,dynamic>?) != null ? LayerResponseReturnParams.fromJson(json['Layer_Response_Return_Params'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'Layer_Response_STATUS_Success_Fail' : layerResponseSTATUSSuccessFail,
    'Layer_Response_Message' : layerResponseMessage,
    'Layer_Response_Return_Params' : layerResponseReturnParams?.toJson()
  };
}

class LayerResponseReturnParams {
  final String? spaceSaved;
  final String? conversionRatio;
  final String? inputFileSize;
  final String? compressFileSize;
  final String? compressFileURL;
  final String? excpMSG;

  LayerResponseReturnParams({
    this.spaceSaved,
    this.conversionRatio,
    this.inputFileSize,
    this.compressFileSize,
    this.compressFileURL,
    this.excpMSG,
  });

  LayerResponseReturnParams.fromJson(Map<String, dynamic> json)
      : spaceSaved = json['SpaceSaved'] as String?,
        conversionRatio = json['ConversionRatio'] as String?,
        inputFileSize = json['InputFileSize'] as String?,
        compressFileSize = json['CompressFileSize'] as String?,
        compressFileURL = json['CompressFileURL'] as String?,
        excpMSG = json['ExcpMSG'] as String?;

  Map<String, dynamic> toJson() => {
    'SpaceSaved' : spaceSaved,
    'ConversionRatio' : conversionRatio,
    'InputFileSize' : inputFileSize,
    'CompressFileSize' : compressFileSize,
    'CompressFileURL' : compressFileURL,
    'ExcpMSG' : excpMSG
  };
}

class LayerName {
  final String? layerType;
  final String? layerServiceName;

  LayerName({
    this.layerType,
    this.layerServiceName,
  });

  LayerName.fromJson(Map<String, dynamic> json)
      : layerType = json['Layer_Type'] as String?,
        layerServiceName = json['Layer_ServiceName'] as String?;

  Map<String, dynamic> toJson() => {
    'Layer_Type' : layerType,
    'Layer_ServiceName' : layerServiceName
  };
}
