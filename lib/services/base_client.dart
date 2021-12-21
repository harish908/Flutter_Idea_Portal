import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idea_portal/ui/widgets/dialogs/message_dialog.dart';
import 'app_exceptions.dart';

class BaseClient {
  static const TIME_OUT_DURATION = 6;
  //GET
  static Future<dynamic> get(String baseURL, String apiPath) async {
    var uri = Uri.parse(baseURL + apiPath);
    try {
      var response = await http
          .get(uri)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      MessageDialog.showDialog('Connect to data/wifi');
    } on TimeoutException {
      MessageDialog.showDialog('Try Again');
    }
  }

  //POST
  static Future<dynamic> post(
      String baseURL, String apiPath, dynamic payloadObj) async {
    var uri = Uri.parse(baseURL + apiPath);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      MessageDialog.showDialog('Connect to data/wifi');
    } on TimeoutException {
      MessageDialog.showDialog('Connection timeout');
    }
  }

  //DELETE
  static Future<dynamic> delete(
      String baseURL, String apiPath, dynamic payloadObj) async {
    var uri = Uri.parse(baseURL + apiPath);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .delete(uri, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      MessageDialog.showDialog('Connect to data/wifi');
    } on TimeoutException {
      MessageDialog.showDialog('Connection timeout');
    }
  }

  static dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
