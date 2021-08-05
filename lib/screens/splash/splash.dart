import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/profile/profile_screen.dart';
import 'package:flutter_autonomous_learning_app/widget/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 100.0),
              height: 300,
              width: 300,
              child: Image.asset('assets/images/splash1.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 200.0, bottom: 30.0),
              child: Text(
                  'Many great learning source out there reviewed and concluded by you and many others here',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                  textAlign: TextAlign.justify),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              width: 150,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blue.shade300,
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavBar()));
                }, //go to profile
                child: Text(
                  'Understandable',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
