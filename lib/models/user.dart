import 'package:happening/api/apiRepo.dart';
import 'package:happening/constants/constants.dart';

main() {
  print('j');
}

class User {
  String id;
  String name;
  String email;
  DateTime createdAt;
  DateTime dob;
  String status;
  String about;
  String image;
  List<User> followers = [];
  User({
    this.about,
    this.createdAt,
    this.dob,
    this.email,
    this.followers,
    this.id,
    this.name,
    this.status,
    this.image,
  });
  Future<User> ensureData() async {
    Map resp = await ApiRepository().getOneUser(id: id);
    if (resp['success'] == true && resp['data'] is Map) {
      return User.fromDynamic(resp['data']);
    }
    return this;
  }

  bool hasData() => name != null;
  setUser(User user) {
    about ??= user.about;
    createdAt ??= user.createdAt;
    dob ??= user.dob;
    email ??= user.email;
    followers ??= user.followers;
    name ??= user.name;
    status = user.status;
    image ??= user.image;
  }

  bool checkData() {
    if (name == null) return false;
    if (followers == null) return false;
    if (followers.isEmpty) return true;
    return followers.first.name != null;
  }

  @override
  bool operator ==(Object t) {
    if (t is User) {
      return t.id == this.id;
    } else {
      return false;
    }
  }

//create user
  static User fromMap(Map map) {
    List followRESp = map['followers'];
    if (followRESp == null) {
      followRESp = [];
    }
    return User(
        about: map['about'],
        followers: followRESp.map((e) => User.fromDynamic(e)).toList(),
        email: map['email'],
        id: map['_id'],
        name: map['name'],
        createdAt: DateTime.tryParse(map['createdAt']),
        status: map['status'],
        image: map['img']);
  }

  static User fromID(String _id) {
    return User(id: _id);
  }

  static User fromDynamic(dynamic dyn) {
    if (dyn is User) return dyn;
    if (dyn == null || dyn == '') {
      return User(
        name: DefaultTexts.userNAname,
        about: DefaultTexts.userNAabout,
        status: DefaultTexts.userNAstatus,
      );
    }
    if (dyn is String) return User.fromID(dyn);
    if (dyn is Map) return User.fromMap(dyn);
    return User(
      name: DefaultTexts.userNAname,
      about: DefaultTexts.userNAabout,
      status: DefaultTexts.userNAstatus,
    );
  }
}
