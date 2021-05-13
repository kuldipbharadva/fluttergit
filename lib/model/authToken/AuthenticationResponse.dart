import 'package:flutter_learn_app/model/authToken/ResponseData.dart';

class AuthenticationResponse {
 /* int success;
  String message;
  ResponseData responseData;

  AuthenticationResponse({this.success, this.message, this.responseData});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseData = json['responseData'] != null
        ? new ResponseData.fromJson(json['responseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.responseData != null) {
      data['responseData'] = this.responseData.toJson();
    }
    return data;
  }*/
  int id;
  String firstName;
  String lastName;
  String username;
  Null password;
  String token;

  AuthenticationResponse(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.password,
        this.token});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}