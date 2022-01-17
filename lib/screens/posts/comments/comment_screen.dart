// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final String CurrentTopicID;
  const CommentScreen({Key? key, required this.CurrentTopicID})
      : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
    _getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CommentSection(),
      ),
    );
  }

  Widget CommentSection() {
    return ListView.separated(
      itemCount: Comments == null ? 0 : Comments.length, //get comment
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  'user ' + Comments[index]['user_id'],
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 10, right: 5),
            child: Container(
              width: MediaQuery.of(context).size.width - 45,
              child: Text(
                Comments[index]['content'],
                style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  List<Map> Comments = <Map>[];
  Future<void> _getComments() async {
    var url = 'https://aku.ndaktau.com/api/topic/' +
        widget.CurrentTopicID +
        '/comment';
    const param = '/topic?search=_searchText';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      var json = jsonDecode(response.body) as Map;
      Map data = json['data'];
      if (json['errorCode'] == '00') {
        Comments = data as List<Map>;
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
