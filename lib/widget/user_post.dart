import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';

Widget UserTopic() {
  return ListView.separated(
      itemBuilder: (context, index) => Container(
            child: Text('Postnya user'),
          ),
      separatorBuilder: (context, index) => Divider(
            thickness: 1,
            color: Colors.black87,
          ),
      itemCount: 3);
}
