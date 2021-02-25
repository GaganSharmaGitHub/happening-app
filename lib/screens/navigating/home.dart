import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:happening/models/currentuser.dart';
import 'package:happening/models/posts.dart';
import 'package:happening/widgets/basicwidgets.dart';
import 'package:provider/provider.dart';
import 'package:happening/constants/basicConsts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:happening/screens/tabs/tabs.dart';

class HomeScreen extends StatefulWidget {
  final List<Post> feed;
  const HomeScreen({Key key, this.feed}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//    CurrentUser c = context.watch<CurrentUser>();
Future logOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear().then((value) {
    //      Navigator.of(context).pushNamedAndRemoveUntil(
//            Routes.Welcome, (Route<dynamic> route) => false);
  });
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          onPageChanged: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          controller: _controller,
          children: <Widget>[
            FeedTab(
              initFeed: widget.feed,
            ),
            ExploreTab(),
            SearchTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,

          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _controller.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: AppColors.primaryAccent,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Explore'),
              activeColor: AppColors.primaryAccent,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text('Messages'),
              activeColor: AppColors.primaryAccent,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: CircleAvatar(
                backgroundImage: ProfilePic().build(context).image,
                radius: 15,
              ),
              title: Text('Prfile'),
              activeColor: AppColors.primaryAccent,
              inactiveColor: Colors.grey,
            ),
          ],
        ));
  }
}
