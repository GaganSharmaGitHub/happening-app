import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happening/api/authApiRepository.dart';
import 'package:happening/api/userApiRepo.dart';
import 'package:http/http.dart' as http;
import 'package:happening/constants/api.dart';

class PostApiRepository extends UserApiRepository {
  Future<Map> createPost({
    @required String authToken,
    @required String contents,
    String image,
    String repost,
  }) async {
    Uri uri = Uri.https(
      APIEndPoints.apiurl,
      APIEndPoints.allPosts,
    );

    http.Response resp = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": authToken,
        },
        body: jsonEncode(
            {"contents": contents, "image": image, 'repost': repost}));
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> allPosts({Map<String, String> query}) async {
    Uri uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.allPosts, query);
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

  Future<Map> onePost({@required String id}) async {
    Uri uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.onePost(id: '$id'));
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

  Future<Map> deletePost({
    @required Future<Map> id,
    @required String authToken,
  }) async =>
      {};
  Future<Map> updatePost({@required Future<Map> id}) async => {};
  Future<Map> likePost({
    @required String id,
    @required String auth,
  }) async {
    Uri uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.likePost(id: id));

    http.Response resp = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": auth,
      },
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }

  Future<Map> unlikePost({
    @required String id,
    @required String auth,
  }) async {
    Uri uri = Uri.https(APIEndPoints.apiurl, APIEndPoints.unlikePost(id: id));

    http.Response resp = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": auth,
      },
    );
    String bod = resp.body;
    Map decoded = jsonDecode(bod);
    return decoded;
  }
}
