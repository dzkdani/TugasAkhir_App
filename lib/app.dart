import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/splash/splash.dart';
import './screens/sign_in/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    _loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLogin ? SplashScreen() : SignInPage(),
    );
  }

  void _loginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isUser') != null && prefs.getBool('isUser') == true) {
      setState(() {
        _isLogin = true;
      });
    } else {
      _isLogin = false;
    }
  }
}
