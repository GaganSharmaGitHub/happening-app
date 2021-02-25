import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:happening/constants/api.dart';

class AuthApiRepository {
  //unauthorised user activities
  Future<Map> login({
    @required String email,
    @required String password,
  }) async {
    if (email == null || email == '') {
      throw Exception('Enter email ');
    }
    if (password == null || password == '') {
      throw Exception('Enter password');
    }
    Uri uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.loginUser);

    http.Response resp = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> register({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    if (email == null || email == '') {
      throw Exception('Enter email ');
    }
    if (password == null || password == '') {
      throw Exception('Enter password');
    }
    if (name == null || name == '') {
      throw Exception('Enter email and password');
    }
    Uri uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.registerUser);

    http.Response resp = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "name": name,
      }),
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> userForgotPassword() async {}
  Future<Map> userResetPassword() async {}
}
