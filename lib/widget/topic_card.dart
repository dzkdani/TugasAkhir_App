import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/posts/post_view.dart';

class Topic extends StatefulWidget {
  const Topic({Key? key}) : super(key: key);

  @override
  _TopicState createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return TopicCard(context);
  }
}

Widget TopicCard(BuildContext context) {
  String username = "yang ngepost";
  String title = "judul post";
  String desc = "deskripsi post";

  return Card(
    elevation: 3,
    color: Colors.white,
    shadowColor: Colors.black,
    margin: EdgeInsets.all(5.0),
    child: MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostCard(),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  username,
                  style: TextStyle(
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
                  margin: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    desc,
                    style: TextStyle(
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
