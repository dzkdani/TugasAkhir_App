import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final url = 'https://aku.ndaktau.com/api';

class ResponseHandler {
  String errorCode;
  String errorMessage;
  Map data;

  ResponseHandler(
      {required this.errorCode,
      required this.errorMessage,
      required this.data});

  factory ResponseHandler.fromJsonData(Map<String, dynamic> jsonObject) {
    return ResponseHandler(
        errorCode: jsonObject['errorCode'],
        errorMessage: jsonObject['message'],
        data: jsonObject['data']);
  }

  Map _getJsonData() {
    Map<String, dynamic> branchData;
    if (data.containsKey('data')) {
      branchData = data['data'];
      return branchData;
    } else {
      return data;
    }
  }
}
