import 'package:flutter/material.dart';

class ExploreAppBar extends StatefulWidget {
  const ExploreAppBar({Key? key}) : super(key: key);

  @override
  _ExploreAppBarState createState() => _ExploreAppBarState();
}

class _ExploreAppBarState extends State<ExploreAppBar> {
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      floating: true,
      centerTitle: false,
      elevation: 0,
      title: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
        child: TextField(
          controller: _search,
          autocorrect: true,
          onSubmitted: (value) => {}, //search sumting
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              size: 24,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
