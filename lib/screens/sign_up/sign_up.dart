import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/constant.dart';
import 'package:flutter_autonomous_learning_app/screens/splash/splash.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();

  var _password = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, Colors.white]),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 100.0, left: 50.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    icon: Icon(Icons.email_rounded),
                    hintText: 'e-mail',
                  ),
                  controller: _mailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    icon: Icon(Icons.account_circle_rounded),
                    hintText: 'username',
                  ),
                  controller: _usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    icon: Icon(Icons.account_circle_rounded),
                    hintText: 'display name',
                  ),
                  controller: _displayNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0, right: 50.0, bottom: 50.0),
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
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter tour password' : null,
                  onSaved: (value) => _password = value!,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3.2,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                ),
                child: MaterialButton(
                    onPressed: register, //register
                    child: const Text('Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    const url = 'https://aku.ndaktau.com/api/register';
    const param = '/register';
    try {
      if (_mailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _displayNameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(url),
            headers: ({}),
            body: ({
              'email': _mailController.text,
              'username': _usernameController.text,
              'password': _passwordController.text,
              'display_name': _displayNameController.text,
            }));
        final json = jsonDecode(response.body) as Map;
        Map data = json['data'];
        final token = data['token'] as String;
        if (json['message'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isUser', true);
          await prefs.setString('token', token);
          Future.delayed(Duration(seconds: 2), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SplashScreen()));
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid"),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email/Username has been taken"),
          duration: Duration(seconds: 3)));
    }
  }
}
