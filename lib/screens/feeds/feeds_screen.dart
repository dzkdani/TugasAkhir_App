import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/posts/post_create.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
        centerTitle: true,
        backwardsCompatibility: false,
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
        child: Icon(Icons.add_box_sharp),
      ),
    );
  }

  Widget FeedsTopic() {
    return ListView.separated(
        itemBuilder: (context, index) => Container(
              child: TopicCard(context),
            ),
        separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: Colors.black87,
            ),
        itemCount: 10);
  }
}
