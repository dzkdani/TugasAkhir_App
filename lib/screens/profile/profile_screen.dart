import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/models/topic_model.dart';
import 'package:flutter_autonomous_learning_app/screens/sign_in/sign_in.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';
import 'package:flutter_autonomous_learning_app/widget/profile_widget.dart';
import 'package:flutter_autonomous_learning_app/widget/profile_tab_bar.dart';
import 'package:flutter_autonomous_learning_app/widget/insta_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

String displayName = 'displayname';
String bioText = 'bio';
int totalTopics = 0;
List<Map> Topics = <Map>[];

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _getProfile();
    _getUserTopics();
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    var _pageIndex = 0;

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
          child: const Icon(Icons.arrow_forward_sharp),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileStats(screen: _screenSize, color: Colors.white10),
            bio(primaryColor: Colors.white, bio: bioText),
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
              onTap: (value) {},
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Topics == null ? 0 : Topics.length,
              itemBuilder: (contex, index) {
                return Container(
                  padding: _pageIndex == 1
                      ? const EdgeInsets.all(2)
                      : const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: _pageIndex == 1
                        ? BorderRadius.circular(15)
                        : BorderRadius.circular(0),
                    child: TopicCard(context, index),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getUserTopics() async {
    const url = 'https://aku.ndaktau.com/api/feeds';
    const param = '/feeds';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      var json = jsonDecode(response.body) as Map;
      Map data = json['data'];
      if (json['errorCode'] == '00') {
        Topics = List<Map>.from(data['data']);
        totalTopics = data['total'];
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getProfile() async {
    const url = 'https://aku.ndaktau.com/api/profile';
    const param = '/profile';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await http.get(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var json = jsonDecode(response.body) as Map;
    Map data = json['data'];
    if (json['message'] == 'success') {
      displayName = data['display_name'].toString();
      String _bio =
          (data['bio'] + "\n" + data['birth_date'] + "\n" + data['website'])
              .toString();
      bioText = _bio;
      setState(() {});
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isUser');
    prefs.remove('token');
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    });
  }
}
