import 'package:flutter/material.dart';
import 'package:watch_store/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;

  const CustomAppBar({this.appBarTitle = ""});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      elevation: 0,
      centerTitle: true,
      title: Text(
        appBarTitle,
        style: kTextAppBarTitle,
      ),
    );
  }
}
