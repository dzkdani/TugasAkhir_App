import 'package:flutter/material.dart';
import 'package:flutter_autonomous_learning_app/screens/explore/explore_screen.dart';
import 'package:flutter_autonomous_learning_app/screens/feeds/feeds_screen.dart';
import 'package:flutter_autonomous_learning_app/screens/posts/post_view.dart';
import 'package:flutter_autonomous_learning_app/screens/profile/profile_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final List<Widget> _screens = <Widget>[
    FeedsScreen(), //Text("Feeds"), //change to feeds
    ExploreScreen(),
    ProfileScreen(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          iconSize: 22,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Feeds',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ]),
    );
  }
}
