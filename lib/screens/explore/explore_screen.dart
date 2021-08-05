import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/explore/explore_appBar.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

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
              decoration: InputDecoration(
                hintText: 'give me a topic',
                icon: Icon(Icons.search_sharp),
              ),
              onChanged: (value) => {print(value)},
            ),
          ),
          Expanded(child: ExploreResult()),
        ],
      ),
    );
  }

  Widget ExploreResult() {
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
