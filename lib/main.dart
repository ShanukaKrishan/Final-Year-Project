import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/homeScreen/homeScreen.dart';
import 'loginScreen/loginScreen.dart';
import 'profileScreen/profileScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        routes: routes,
        home: const StartPoint(),
      ),
      designSize: const Size(360, 590),
    );
  }
}

class StartPoint extends StatefulWidget {
  const StartPoint({Key? key}) : super(key: key);

  @override
  _StartPointState createState() => _StartPointState();
}

class _StartPointState extends State<StartPoint> {
  final screens = const [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        FontAwesomeIcons.home,
        size: 20,
      ),
      const Icon(
        FontAwesomeIcons.shoppingCart,
        size: 20,
      ),
      const Icon(
        FontAwesomeIcons.solidUser,
        size: 20,
      ),
    ];
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black12,
        backgroundColor: Colors.transparent,
        height: 60,
        items: items,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
