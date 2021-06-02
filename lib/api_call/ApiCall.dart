import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/model/authToken/AuthenticationResponse.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class ApiCall {
  static final String _baseUrl = "https://reqbin.com/echo/";

  static Map<String, String> getHeader(String token) {
    Map<String, String> myHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "bearer $token"
    };
    return myHeader;
  }

  static Future<dynamic> makeApiCall(
      BuildContext context, String url, MethodType methodType,
      {Map<String, String> headers, dynamic body}) async {
    var responseJson;
    Map<String, String> defaultHeaders = {"Content-type": "application/json"};
    try {
      print("req url :: " + url);
      print("req header :: " + headers.toString());
      print("req body :: " + body.toString());

      Response response;
      switch (methodType) {
        case MethodType.GET:
          response = await http.get(Uri.parse(url),
              headers: headers != null ? headers : defaultHeaders);
          break;
        case MethodType.POST:
          response = await http.post(Uri.parse(url),
              headers: headers != null ? headers : defaultHeaders,
              body: body != null ? jsonEncode(body) : {});
          break;
        case MethodType.PUT:
          response = await http.put(Uri.parse(url),
              headers: headers != null ? headers : defaultHeaders,
              body: body != null ? jsonEncode(body) : {});
          break;
        case MethodType.DELETE:
          response = await http.delete(Uri.parse(url),
              headers: headers != null ? headers : defaultHeaders);
          break;
        case MethodType.PATCH:
          response = await http.patch(Uri.parse(url),
              headers: headers != null ? headers : defaultHeaders,
              body: body != null ? jsonEncode(body) : {});
          break;
      }

      switch (response.statusCode) {
        case 200:
        case 201:
          return json.decode(response.body.toString());
        case 400:
          CommonFunctions.showToast(
              context, "${response.statusCode} Bad request!");
          break;
        case 401:
          Map<String, String> tokenParam = {
            "username": "admin",
            "password": "admin123"
          };
          Response resToken = await http.post(
              Uri.parse("http://sagarsinh-001-site1.ctempurl.com/api/Authenticate/authenticate"),
              headers: defaultHeaders,
              body: jsonEncode(tokenParam));
          AuthenticationResponse tokenRes =
              AuthenticationResponse.fromJson(jsonDecode(resToken.body));
          String newToken = tokenRes.token;
          print("token :: " + tokenRes.token);
          responseJson = await makeApiCall(context, url, methodType,
              headers: headers != null ? getHeader(newToken) : defaultHeaders,
              body: body);
          break;
        case 403:
          CommonFunctions.showToast(
              context, "${response.statusCode} Forbidden!");
          break;
        case 404:
          CommonFunctions.showToast(
              context, "${response.statusCode} Not found!");
          break;
        case 405:
          CommonFunctions.showToast(
              context, "${response.statusCode} Method not allowed!");
          break;
        case 406:
          CommonFunctions.showToast(
              context, "${response.statusCode} Not accepted!");
          break;
        case 409:
          CommonFunctions.showToast(
              context, "${response.statusCode} Conflict!");
          break;
        case 500:
          CommonFunctions.showToast(
              context, "${response.statusCode} Internal server error!");
          break;
        case 502:
          CommonFunctions.showToast(
              context, "${response.statusCode} Bad gateway!");
          break;
        default:
          CommonFunctions.showToast(
              context, "${response.statusCode} Something went wrong!");
          return responseJson;
      }
    } on SocketException {
      return throw Exception('No Internet connection');
    } on Exception catch (exception) {
      return exception;
    }
    return responseJson;
  }


  static Future<String> callPostImage(
      String url, file, String fileKey, Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": ""
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.fields.addAll(body);

    if (file != null) {
      request.files.add(http.MultipartFile(
          fileKey, file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split("/").last));
    }

    return request.send().then((response) async {
      return response.stream.bytesToString().then((responseString) {
        return responseString;
      });
    }).catchError((onError) {
      print("onError " + onError.toString());
    }).whenComplete(() => {print("whenComplete")});
  }

  static Future<String> callPostMultipleImage(
      String url, Map<String, String> body, Map<String, File> fileBody) async {
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": ""
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.fields.addAll(body);

    fileBody.forEach((fileKey, file) async {
      if (file != null) {
        var stream =
        new http.ByteStream(DelegatingStream.typed(file.openRead()));
        var length = await file.length();
        var multipartFile = new http.MultipartFile(fileKey, stream, length,
            filename: basename(file.path));
        request.files.add(multipartFile);
      }
    });

    return request.send().then((response) async {
      return response.stream.bytesToString().then((responseString) {
        return responseString;
      });
    }).catchError((onError) {
      print("onError " + onError.toString());
    }).whenComplete(() => {print("whenComplete")});
  }

  static Future<String> callPostMultipleImageArray(String url,
      Map<String, String> body, List<File> files, String fileKey) async {
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": ""
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.fields.addAll(body);

    files.forEach((file) async {
      if (file != null) {
        var stream =
        new http.ByteStream(DelegatingStream.typed(file.openRead()));
        var length = await file.length();
        var multipartFile = new http.MultipartFile(fileKey, stream, length,
            filename: basename(file.path));
        request.files.add(multipartFile);
      }
    });

    return request.send().then((response) async {
      return response.stream.bytesToString().then((responseString) {
        return responseString;
      });
    }).catchError((onError) {
      print("onError " + onError.toString());
    }).whenComplete(() => {print("whenComplete")});
  }
}

enum MethodType { GET, POST, PUT, DELETE, PATCH }
