import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/sign_in/sign_in.dart';
import 'package:flutter_autonomous_learning_app/screens/splash/splash.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_autonomous_learning_app/widget/profile_widget.dart';
import 'package:flutter_autonomous_learning_app/common/utils.dart';
import 'package:flutter_autonomous_learning_app/widget/profile_tab_bar.dart';
import 'package:flutter_autonomous_learning_app/widget/insta_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String displayName = 'displayname';

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    var _pageIndex;

    int postCount = 3;
    int savedCount = 7;

    return Scaffold(
      appBar: InstaAppBar(
        height: 80,
        center: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              displayName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        trailing: MaterialButton(
          onPressed: _logout,
          child: Icon(Icons.arrow_forward_sharp),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileStats(screen: _screenSize, color: Colors.white10),
            bio(primaryColor: Colors.white),
            editProfile(
              primaryColorDark: Colors.white10,
              primaryColor: Colors.white,
            ),
            Divider(
              height: 1,
              color: Colors.grey[500],
            ),
            ProfileTabBar(
              height: 46,
              onTap: (value) {
                setState(() {
                  var _pageIndex = value;
                });
              },
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (contex, index) {
                return Container(
                  padding:
                      _pageIndex == 1 ? EdgeInsets.all(2) : EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: _pageIndex == 1
                        ? BorderRadius.circular(15)
                        : BorderRadius.circular(0),
                    child: TopicCard(context),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isUser');
    prefs.remove('token');
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    });
  }
}
