import 'package:flutter/material.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:happening/constants/defaults.dart';
import 'package:happening/models/currentuser.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:happening/widgets/basicwidgets.dart';

class UserTile extends StatefulWidget {
  final User user;
  final Widget trail;
  UserTile({this.trail, @required this.user});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
    ensure();
  }

  ensure() async {
    if (!user.hasData()) user = await user.ensureData();
    if (user.hasData()) {
      setState(() {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!user.hasData())
      return ListTileSkeleton(
        style: SkeletonStyle(
          theme: SkeletonTheme.Light,
          isShowAvatar: true,
          isCircleAvatar: true,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          padding: EdgeInsets.all(15.0),
          barCount: 0,
          colors: [
            Colors.grey[400],
            Colors.grey[500],
            Colors.grey[600],
          ],
          isAnimation: true,
        ),
      );
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            Image.network(user.image ?? DefaultTexts.defImage).image,
      ),
      title: Text('${user.name}'),
      trailing: widget.trail,
      onTap: () {
        Navigator.of(context).pushNamed(Routes.UserScreen, arguments: user);
      },
    );
  }
}
