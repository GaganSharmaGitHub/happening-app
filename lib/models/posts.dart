import 'package:happening/api/apiRepo.dart';
import 'package:happening/models/currentuser.dart';

class Post {
  User author;
  String contents;
  String id;
  String image;
  List tags;
  List<User> likes;
  DateTime created;
  Post repost;
  bool hasData() => contents != null;

  Post(
      {this.author,
      this.contents,
      this.likes,
      this.tags,
      this.image,
      this.created,
      this.id,
      this.repost});
  Future<Post> ensureData() async {
    Map resp = await ApiRepository().onePost(id: id);
    if (resp['success'] == true && resp['data'] is Map) {
      return Post.fromDynamic(resp['data']);
    }
    return this;
  }

  static Post fromMap(Map mp) {
    mp["tags"] ??= [];
    mp["likes"] ??= [];
    mp["tags"] = mp["tags"] == [null] ? [] : mp["tags"];
    List like = mp['likes'];
    return Post(
      author: User.fromDynamic(mp['author']),
      contents: mp['contents'],
      created: DateTime.tryParse(mp['createdAt']),
      image: mp['image'],
      likes: like.map((e) => User.fromDynamic(e)).toList(),
      tags: mp['tags'],
      id: mp['_id'],
      repost: mp['repost'] == null
          ? null
          : Post.fromDynamic(
              mp['repost'],
            ),
    );
  }

  static Post fromDynamic(dynamic dyn) {
    if (dyn is Map) return fromMap(dyn);
    if (dyn is String) return fromID(dyn);
    if (dyn is Post) return dyn;
    return Post(contents: 'corrupt post');
  }

  static Post fromID(String mp) {
    return Post(
      id: mp,
    );
  }
}
