import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:scam_stories_app/view/screens/search_screen.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            FeatherIcons.home,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Get.to(() => SearchScreen());
            },
            icon: Icon(
              FeatherIcons.search,
              color: Colors.white,
            ),
          ),
          Icon(
            FeatherIcons.bell,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
