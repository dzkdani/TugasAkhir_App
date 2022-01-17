// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/posts/post_view.dart';
import 'package:flutter_autonomous_learning_app/screens/feeds/feeds_screen.dart';
import 'package:flutter_autonomous_learning_app/screens/profile/profile_screen.dart';

class Topic extends StatefulWidget {
  const Topic({Key? key}) : super(key: key);

  @override
  _TopicState createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget TopicCard(BuildContext context, int index) {
  int _topicID = Topics[index]['id'];

  return Card(
    elevation: 3,
    color: Colors.white,
    shadowColor: Colors.black,
    margin: const EdgeInsets.all(5.0),
    child: MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostCard(
              TopicOwner: _topicID.toString(),
              TopicTitle: Topics[index]['title'],
              TopicDesc: Topics[index]['description'],
              TopicDate: Topics[index]['created_at'],
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  "UserID: " + Topics[index]['user_id'].toString(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 85,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Topics[index]['title'],
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Topics[index]['description'],
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                //LIKE AND COMMENT
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     MaterialButton(
                //       onPressed: () {
                //         setState(() {});
                //       },
                //       child: Container(
                //         height: 14,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(20),
                //           ),
                //         ),
                //         child: Text(
                //           'Like',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 12,
                //             fontFamily: 'Roboto',
                //           ),
                //         ),
                //       ),
                //     ),
                //     MaterialButton(
                //       onPressed: () {},
                //       child: Container(
                //         height: 14,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(20),
                //           ),
                //         ),
                //         child: Text(
                //           'Comments',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Colors.black87,
                //             fontSize: 12,
                //             fontFamily: 'Roboto',
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
