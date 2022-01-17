// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/posts/post_create.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  void initState() {
    super.initState();
    _getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds'),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: FeedsTopic(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
        child: const Icon(Icons.add_box_sharp),
      ),
    );
  }

  Widget FeedsTopic() {
    return ListView.separated(
        itemBuilder: (context, index) => Container(
              child: TopicCard(context, index),
            ),
        separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              color: Colors.black87,
            ),
        itemCount: Feeds == null ? 0 : Feeds.length);
  }

  List<Map> Feeds = <Map>[];
  Future<void> _getTopics() async {
    const url = 'https://aku.ndaktau.com/api/topic';
    const param = '/topic';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      var json = jsonDecode(response.body) as Map;
      Map data = json['data'];
      if (json['errorCode'] == '00') {
        Feeds = List<Map>.from(data['data']);
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
