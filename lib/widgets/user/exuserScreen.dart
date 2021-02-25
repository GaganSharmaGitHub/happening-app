import 'package:flutter/material.dart';
import 'package:happening/constants/constants.dart';
import 'package:happening/models/user.dart';
import 'package:happening/painter/splashyPainter.dart';
import 'package:happening/widgets/user/userheader.dart';

class ExUserScreen extends StatefulWidget {
  final User user;
  ExUserScreen(this.user);
  @override
  _ExUserScreenState createState() => _ExUserScreenState();
}

class _ExUserScreenState extends State<ExUserScreen> {
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
  }

  List<Widget> widg() {
    List<Widget> p = [];
    for (int i; i < 22; i++) {
      p.add(ListTile(
        title: Text('item $i'),
      ));
    }
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: UserPageHeader(user: user, max: 400, min: 100),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, j) => ListTile(
                  title: Text('item $j'),
                )),
          )
        ],
      ),
    );
  }
}

class UserScreenTop extends StatelessWidget {
  const UserScreenTop({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Container(
                color: randomColor(),
                alignment: Alignment.topLeft,
                child: SafeArea(child: BackButton()),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('${user.status}'),
                    Row(
                      children: [
                        Text('${user.followers.length} followers'),
                        Text('joined on ${user.createdAt.toUtc()} '),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 60,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.image ?? DefaultTexts.defImage),
          ),
        ),
      ],
    );
  }
}
