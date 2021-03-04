import 'package:happening/api/apiRepo.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/models/tag.dart';
import 'package:happening/models/user.dart';

class FeedResponse {
  User user;
  List<Post> feed;
  FeedResponse({this.feed, this.user});
}

class PostServices {
  Future<List<Post>> getUserPosts(String userid) async {
    Map map = await ApiRepository().allPosts(query: {'author': userid});
    List temp = [];

    if (map['data'] is List) temp = map['data'];
    return temp.map<Post>((e) => Post.fromDynamic(e)).toList();
  }

  Future<List<TagTrending>> trendingTags() async {
    Map map = await ApiRepository().trendingTags();
    if (map['success'] == true) {
      List mp = map['tags'] ?? [];
      List<TagTrending> r = [];
      for (var e in mp) {
        if (e['_id'] != null) {
          r.add(TagTrending(
              count: e['count'] is num ? e['count'] : 0, tag: '${e['_id']}'));
        }
      }
      return r;
    } else {
      throw '';
    }
  }

  Future<FeedResponse> feed(String auth) async {
    Map map = await ApiRepository().myfeed(authToken: auth);
    if (map['success'] == true) {
      User user = User.fromDynamic(map['user']);
      List mpost = map['posts'] is Map
          ? map['posts']['data'] is List
              ? map['posts']['data']
              : []
          : [];
      List<Post> posts = mpost.map((e) => Post.fromDynamic(e)).toList();
      return FeedResponse(user: user, feed: posts);
    } else {
      throw 'Sorry we could not log you in.... ${map['reason']}';
    }
  }
}
