import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/constant.dart';
import 'package:flutter_autonomous_learning_app/widget/navigation_bar.dart';
import '../sign_up/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = false;

  var _user;
  var _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 180, right: 10),
                height: 280,
                width: 310,
                child: const Text(
                  'Learn \nnew things together',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  icon: Icon(Icons.account_circle),
                  hintText: 'e-mail / username',
                ),
                controller: userController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  icon: Icon(Icons.lock),
                  hintText: 'password',
                ),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.2,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                  onPressed: () {
                    login();
                  }, //login
                  child: const Text('Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ))),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 50,
              child: MaterialButton(
                  onPressed: () {}, //forgot pwd
                  child: const Text('Forgot Password?',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline))),
            ),
            Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  'First Time? Learn new things and ',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width / 3.2,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  }, //to register
                  child: const Text('Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ))),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kPrimaryColor, Colors.white]),
        ),
      )),
    );
  }

  Future<void> login() async {
    const url = 'https://aku.ndaktau.com/api/login';
    const param = '/login';
    try {
      if (passwordController.text.isNotEmpty &&
          userController.text.isNotEmpty) {
        var response = await http.post(Uri.parse(url),
            headers: ({}),
            body: ({
              'username': userController.text,
              'password': passwordController.text
            }));
        final json = jsonDecode(response.body) as Map;
        Map data = json['data'];
        var token = data['token'] as String;
        if (json['message'] == 'success') {
          isLogin = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isUser', true);
          await prefs.setString('token', token);
          Future.delayed(
            Duration(seconds: 1),
            () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NavBar()));
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid"),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      print('alah kontol');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username/Password is Incorrect"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
