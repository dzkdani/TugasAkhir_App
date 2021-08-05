import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
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
      itemCount: 5, //get comment
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  'kang komen',
                  style: TextStyle(
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
                'The authorization header will be automatically generated when you send the request. he authorization header will be automatically generated when you send the request. ',
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
}
