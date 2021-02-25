import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happening/api/postsApiRepository.dart';
import 'package:http/http.dart' as http;
import 'package:happening/constants/api.dart';

class ApiRepository extends PostApiRepository {
  Future<Map> trendingTags() async {
    Uri uri = Uri.https(
      APIEndPoints.apiurl,//api deployment url
      APIEndPoints.trendingTags,
    );

    http.Response resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }
}
