import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileTabBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final ValueChanged<int> onTap;

  ProfileTabBar({
    Key? key,
    required this.height,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProfileTabBarState createState() => _ProfileTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  bool isPost = true;
  bool isSaved = false;

  final Color _selectedColor = Colors.black;
  final Color _unSelectedColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
              child: Container(
                color: Colors.white,
                width: _screenWidth / 2,
                height: widget.height,
                child: Stack(
                  children: <Widget>[
                    Align(
                      child: Icon(
                        Icons.grid_on,
                        color: isPost ? _selectedColor : _unSelectedColor,
                      ),
                    ),
                    isPost
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              onTap: () {
                if (!isPost) {
                  setState(() {
                    setFlags(tabName: 'post');
                    widget.onTap(0);
                  });
                }
              }),
          GestureDetector(
            child: Container(
              color: Colors.white,
              width: _screenWidth / 2,
              height: widget.height,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Icon(
                      Icons.assignment_ind,
                      color: isSaved ? _selectedColor : _unSelectedColor,
                    ),
                  ),
                  isSaved
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            onTap: () {
              if (!isSaved) {
                setState(() {
                  setFlags(tabName: 'saved');
                  widget.onTap(1);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  setFlags({String? tabName}) {
    switch (tabName) {
      case 'post':
        isSaved = false;
        isPost = true;
        break;

      case 'saved':
        isSaved = true;
        isPost = false;
        break;
    }
  }
}
