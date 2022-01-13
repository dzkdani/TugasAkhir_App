import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _refsTitleController = TextEditingController();
  TextEditingController _refsUrlController = TextEditingController();
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.save_rounded),
      // ),
      appBar: AppBar(
        title: Text('Post a Topic'),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.blue,
            ),
            child: MaterialButton(
              disabledColor: Colors.grey,
              onPressed: () {
                setState(() {
                  isTopicSubmitted ? () => null : _submitTopic();
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
                      decoration: BoxDecoration(
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

  void _submitTopic() {
    print('object');
    isTopicSubmitted = true;
  }

  void _addReference() {
    _refsTitleController.clear();
    _refsUrlController.clear();
  }
}
