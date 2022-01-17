import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/explore/explore_appBar.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchBarController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _searchBarController,
              decoration: const InputDecoration(
                hintText: 'give me a topic',
                icon: Icon(Icons.search_sharp),
              ),
              onChanged: (value) => {_exploreTopics(value)},
            ),
          ),
          Expanded(child: ExploreResult()),
        ],
      ),
    );
  }

  List<Map> Searchs = <Map>[];
  Widget ExploreResult() {
    return ListView.separated(
        itemBuilder: (context, index) => Container(
              child: TopicCard(context, index),
            ),
        separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: Colors.black87,
            ),
        itemCount: Searchs == null ? 0 : Searchs.length);
  }

  Future<void> _exploreTopics(String _search) async {
    var url = 'https://aku.ndaktau.com/api/topic?search=';
    const param = '/topic?search=_searchText';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print(_search);
    try {
      var response = await http.get(Uri.parse(url + _search),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      var json = jsonDecode(response.body) as Map;
      Map data = json['data'];
      if (json['errorCode'] == '00') {
        Searchs = List<Map>.from(data['data']);
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
