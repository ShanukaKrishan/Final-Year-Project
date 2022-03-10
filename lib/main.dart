import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/homeScreen/homeScreen.dart';

import 'package:watch_store/providers/cartProvider.dart';

import 'providers/productsProvider.dart';

import 'package:watch_store/widgets/utils.dart';
import 'package:watch_store/widgets/verifyEmailScreen.dart';
import 'loginScreen/loginScreen.dart';
import 'profileScreen/profileScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          routes: routes,
          home: const MainPage(),
        ),
        designSize: const Size(360, 590),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmailScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
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
        size: 15,
        color: kPrimaryColor,
      ),
      const Icon(
        FontAwesomeIcons.shoppingCart,
        color: kPrimaryColor,
        size: 15,
      ),
      const Icon(
        FontAwesomeIcons.solidUser,
        color: kPrimaryColor,
        size: 15,
      ),
    ];
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 450),
        color: Colors.black,
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        height: 45,
        items: items,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
