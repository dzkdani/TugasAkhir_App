import 'package:flutter/material.dart';

class InstaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool isProfileScreen;
  final Widget center;
  final Widget trailing;
  final Color backgroundColor;

  const InstaAppBar({
    Key? key,
    required this.height,
    required this.center,
    required this.trailing,
    this.isProfileScreen = false,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      height: height,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: isProfileScreen
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                  ),
          ),
          Expanded(
            child: Align(
              child: center,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
