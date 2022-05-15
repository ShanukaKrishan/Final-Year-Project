import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/loginScreen/loginScreen.dart';
import 'package:watch_store/main.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryScreen.dart';
import 'package:watch_store/wishListScreen/wishListScreen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text("More"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.heart,
              color: kPrimaryColor,
              size: 24,
            ),
            title: const Text(
              "Wishlist",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: kDMSerifDisplay,
                  fontSize: 16),
            ),
            onTap: () {
              pushNewScreen(context,
                  screen: const WishListScreen(), withNavBar: false);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: kPrimaryColor,
              size: 26,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: kDMSerifDisplay,
                  fontSize: 16),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              setState(() {});
              // Navigator.popAndPushNamed(context, LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
