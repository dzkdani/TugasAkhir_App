import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/widget/topic_card.dart';

Widget UserSavedTopic() {
  return ListView.separated(
      itemBuilder: (context, index) => Container(
            child: Text('saved postnya user'),
          ),
      separatorBuilder: (context, index) => Divider(
            thickness: 1,
            color: Colors.black87,
          ),
      itemCount: 3);
}
