import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happening/api/authApiRepository.dart';
import 'package:happening/utils/imageUtil.dart';
import 'package:http/http.dart' as http;
import 'package:happening/constants/api.dart';
import 'dart:io';

class UserApiRepository extends AuthApiRepository {
  Future<Map> userChangePassword({@required String authToken}) async => {};
  Future<Map> userUpdate({@required String authToken}) async => {};
  Future<Map> userUploadimage(
      {@required String authToken, @required File image}) async {
    String encoded = 'data:image/png;base64,' + base64fromFile(image);
    ;
    var uri = Uri.https(
      APIEndPoints.apiurl,
      '/api/v1/users/uploadImage',
    );

    http.Response resp = await http.put(
      uri,
      headers: {'Content-Type': 'application/json', "Authorization": authToken},
      body: jsonEncode({"image": encoded}),
    );
    String bod = resp.body;
    print(bod);
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> getOneUser({@required String id}) async {
    Uri uri =
        Uri.https(APIEndPoints.apiurl, APIEndPoints.getOneUser(id: '$id'));
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

  Future<Map> followUser(
      {@required String authToken, @required String id}) async {
    Uri uri = Uri.https(
        APIEndPoints.apiurl,
        APIEndPoints.followUser(
          id: '$id',
        ));
    http.Response resp = await http.put(
      uri,
      headers: {
        "Authorization": authToken,
        'Content-Type': 'application/json',
      },
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> unfollowUser(
      {@required String authToken, @required String id}) async {
    Uri uri = Uri.https(
        APIEndPoints.apiurl,
        APIEndPoints.unfollowUser(
          id: '$id',
        ));
    http.Response resp = await http.put(
      uri,
      headers: {
        "Authorization": authToken,
        'Content-Type': 'application/json',
      },
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> lookupUser() async => {};
  Future<Map> queryUser(Map map) async {
    var uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.lookupUser, map);
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

  //feed
  Future<Map> myfeed({@required String authToken}) async {
    var uri = Uri.https(
      APIEndPoints.apiurl,
      APIEndPoints.myfeed,
    );

    http.Response resp = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', "Authorization": authToken},
    );
    String bod = resp.body;
    print(bod);
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> myposts({@required String authToken}) async => {};
}
