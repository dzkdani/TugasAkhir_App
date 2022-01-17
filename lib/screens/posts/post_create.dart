import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _refsTitleController = TextEditingController();
  final TextEditingController _refsUrlController = TextEditingController();
  bool isTopicSubmitted = false;
  bool isReferenceSubmittedVisible = false;

  List<String> referencesTitleToAdd = [];
  List<String> referencesUrlToAdd = [];

  @override
  void initState() {
    isTopicSubmitted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Topic'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 50.0, right: 50.0, bottom: 5.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                icon: Icon(Icons.title_sharp),
                hintText: 'Topic Title',
              ),
              controller: _titleController,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 5.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                icon: Icon(Icons.description_sharp),
                hintText: 'Description',
              ),
              controller: _descController,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.2,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.blue,
            ),
            child: MaterialButton(
              disabledColor: Colors.grey,
              onPressed: () {
                setState(() {
                  isTopicSubmitted ? () => null : _createTopic();
                });
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Visibility(
              visible: true,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 50.0, right: 50.0, bottom: 5.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        icon: Icon(Icons.title_sharp),
                        hintText: 'Reference Title',
                      ),
                      controller: _refsTitleController,
                    ),
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, right: 50.0, bottom: 5.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          icon: Icon(Icons.link_sharp),
                          hintText: 'Reference URL',
                        ),
                        controller: _refsUrlController,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.7,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue,
                      ),
                      child: MaterialButton(
                        disabledColor: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _addReference();
                          });
                        },
                        child: const Text(
                          'Add Reference',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ))
        ],
      ),
    );
  }

  int _currentTopicID = 0;
  Future<void> _createTopic() async {
    const url = 'https://aku.ndaktau.com/api/topic';
    const param = '/topic';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      if (_titleController.text.isNotEmpty && _descController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }, body: {
          'title': _titleController.text,
          'description': _descController.text,
          'is_public': '1'
        });
        var json = jsonDecode(response.body) as Map;
        Map data = json['data'];
        if (json['errorCode'] == '00') {
          _currentTopicID = data['id'];
          isTopicSubmitted = true;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _addReference() async {
    _refsTitleController.clear();
    _refsUrlController.clear();

    var url = 'https://aku.ndaktau.com/api/topic/' +
        _currentTopicID.toString() +
        "/note";
    const param = '/topic/idTopic/note';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      if (_refsTitleController.text.isNotEmpty &&
          _refsUrlController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }, body: {
          'title': _refsTitleController.text,
          'url': _refsUrlController.text,
          'is_public': '1',
          'desc': " "
        });
        var json = jsonDecode(response.body) as Map;
        Map data = json['data'];
        if (json['errorCode'] == '00') {
          print(data.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
