// ignore_for_file: non_constant_identifier_names

import 'package:flutter_autonomous_learning_app/screens/posts/comments/comment_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostCard extends StatefulWidget {
  final String TopicOwner; //id
  final String TopicTitle;
  final String TopicDesc;
  final String TopicDate;
  const PostCard(
      {Key? key,
      required this.TopicOwner,
      required this.TopicTitle,
      required this.TopicDesc,
      required this.TopicDate})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    _getReferences();
    super.initState();
  }

  //follow
  String followText = 'follow';
  bool isFollowing = false;
  Color followColors = Colors.white;

  //like
  String likeText = 'like';
  bool isLiked = false;
  Color likedColors = Colors.black87;

  //comment
  TextEditingController commentController = TextEditingController();

  //saved
  String saveText = 'save';
  bool isSaved = false;
  Color savedColors = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Topic(context, widget.TopicOwner, widget.TopicDate,
        widget.TopicTitle, widget.TopicDesc);
  }

  Scaffold Topic(BuildContext context, String owner, String dateCreated,
      String title, String desc) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: CircleAvatar(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text('User ' + owner),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width - 200),
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: followColors,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () => setState(() {
                        if (isFollowing == false) {
                          followText = 'following';
                          followColors = Colors.blue;
                          isFollowing = true;
                        } else {
                          followText = 'follow';
                          followColors = Colors.white;
                          isFollowing = false;
                        }
                      }),
                      child: Text(
                        followText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.topRight,
                child: Text(dateCreated),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width - 100),
              child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  color: savedColors,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () => setState(() {
                    if (isSaved == false) {
                      saveText = 'saved';
                      savedColors = Colors.blue;
                      isSaved = true;
                    } else {
                      saveText = 'save';
                      savedColors = Colors.white;
                      isSaved = false;
                    }
                  }),
                  child: Text(
                    saveText,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                desc,
                style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: ReferencesCard()),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
                  height: 50,
                  child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'add a comment',
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _sendComment(commentController.text);
                      commentController.clear();
                    });
                  },
                  child: Icon(
                    Icons.arrow_forward_sharp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (isLiked == false) {
                        likeText = 'Liked';
                        likedColors = Colors.blue;
                        isLiked = true;
                      } else {
                        likeText = 'Like';
                        likedColors = Colors.black87;
                        isLiked = false;
                      }
                    });
                  },
                  child: Container(
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      likeText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: likedColors,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentScreen(
                                  CurrentTopicID: widget.TopicOwner,
                                )));
                  },
                  child: Container(
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Comments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card ReferencesCard() {
    return Card(
      color: Colors.white54,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TopicReferences(),
      ),
    );
  }

  List<Map> References = <Map>[];
  Future<void> _getReferences() async {
    var url = 'https://aku.ndaktau.com/api/topic/' +
        widget.TopicOwner.toString() +
        '/note';
    const param = '/topic/id/note';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      var json = jsonDecode(response.body) as Map;
      Map data = json['data'];
      print(json['errorCode'].toString());
      if (json['errorCode'] == '00') {
        References = data as List<Map>;
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget TopicReferences() {
    return ListView.separated(
      itemCount: References == null ? 0 : References.length,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width / 3,
        height: 50,
        child: MaterialButton(
          padding: EdgeInsets.all(10),
          color: Colors.blue,
          onPressed: () {
            _launchURL('${References[index]['url']}');
          },
          child: Text(
            '${References[index]['title']}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  _launchURL(String refsUrl) async {
    if (await canLaunch(refsUrl)) {
      await launch(refsUrl);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("URL is Invalid")));
      throw 'Could not launch $refsUrl';
    }
  }

  Future<void> _sendComment(String _comment) async {
    var url = 'https://aku.ndaktau.com/api/topic/' +
        widget.TopicOwner.toString() +
        '/comment';
    const param = '/topic';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      if (commentController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(url),
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
            body: {'content': commentController.text});
        var json = jsonDecode(response.body) as Map;
        Map data = json['data'];
        if (json['errorCode'] == '00') {
          print(data['content'].toString());
          setState(() {});
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _sendLike() {}

  void _addToSavedTopic() {}
}
