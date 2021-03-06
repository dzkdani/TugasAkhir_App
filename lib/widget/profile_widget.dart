import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget profileStats({Size? screen, Color? color}) {
  int postCount = 0;
  int savedCount = 0;

  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
    color: color,
    height: 210,
    child: Column(
      children: <Widget>[
        Container(
          width: 100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: profileAvatar(
              height: 100,
              width: 100,
            ),
          ),
        ),
        Container(
          width: screen!.width - 100 - 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              statsBox(count: postCount.toString(), title: 'Posts'),
              statsBox(count: savedCount.toString(), title: 'Saved'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget bio({required Color primaryColor, required String bio}) {
  return Container(
    color: Colors.white10,
    height: 50,
    padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            bio,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget editProfile(
    {required Color primaryColor, required Color primaryColorDark}) {
  return Container(
    color: primaryColor,
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      height: 30,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white30,
      ),
      child: const Center(
        child: Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

Widget statsBox({
  required String count,
  required String title,
}) {
  return Container(
    height: 98,
    width: 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    ),
  );
}

Widget profileAvatar({
  required double height,
  required double width,
}) {
  return Container(
    height: height, //155,
    width: width, //155,
    child: Center(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: height - 10, //140,
          width: width - 10, //140,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn.discordapp.com/attachments/881938537690300547/932467686963830864/FJQVnRyXMAUWQhb.png"), //get profile pic
          ),
        ),
      ),
    ),
  );
}
