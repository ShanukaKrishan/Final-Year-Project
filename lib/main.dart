import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/allProductScreen/allProductScreen.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/chatScreen/chatScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/homeScreen/homeScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryScreen.dart';
import 'package:watch_store/providers/addressProvider.dart';

import 'package:watch_store/providers/cartProvider.dart';
import 'package:watch_store/providers/categoryProvider.dart';

import 'providers/productsProvider.dart';

import 'package:watch_store/widgets/utils.dart';
import 'package:watch_store/widgets/verifyEmailScreen.dart';
import 'loginScreen/loginScreen.dart';
import 'profileScreen/profileScreen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'providers/orderProvider.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51KgtQeKwCKbCno4TrJ1bJvN6jAbOXSWw2hoqokswR1CMzAP0HWn9NfnYiaiRK7KKfd2tXipwsOOrRSKVquKyHM4k00Q0yu9yae';
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
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserAddress(),
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
            return const VerifyEmailScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class StartPoint extends StatefulWidget {
  static String routeName = '/StartPoint';
  const StartPoint({Key? key}) : super(key: key);

  @override
  _StartPointState createState() => _StartPointState();
}

class _StartPointState extends State<StartPoint> {
  final _controller = PersistentTabController(initialIndex: 0);

  final screens = [
    const HomeScreen(),
    const AllProductScreen(),
    CartScreen(),
    const ChatScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style10, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const AllProductScreen(),
      CartScreen(),
      const ChatScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        title: "Home",
        activeColorSecondary: Colors.white,
        activeColorPrimary: kPrimaryColor,
        inactiveIcon: const Icon(
          FontAwesomeIcons.home,
          size: 15,
          color: kPrimaryColor,
        ),
        icon: const Icon(
          FontAwesomeIcons.home,
          size: 15,
          color: Colors.white,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: Colors.white,
        activeColorPrimary: kPrimaryColor,
        title: "Products",
        inactiveIcon: const Icon(
          Icons.apps,
          color: kPrimaryColor,
          size: 18,
        ),
        icon: const Icon(
          Icons.apps,
          color: Colors.white,
          size: 18,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: Colors.white,
        activeColorPrimary: kPrimaryColor,
        title: "Cart",
        icon: const Icon(
          FontAwesomeIcons.shoppingCart,
          color: Colors.white,
          size: 15,
        ),
        inactiveIcon: const Icon(
          FontAwesomeIcons.shoppingCart,
          color: kPrimaryColor,
          size: 15,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: Colors.white,
        activeColorPrimary: kPrimaryColor,
        title: "Chat",
        icon: const Icon(
          Icons.message,
          color: Colors.white,
          size: 16,
        ),
        inactiveIcon: const Icon(
          Icons.message,
          color: kPrimaryColor,
          size: 16,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: Colors.white,
        activeColorPrimary: kPrimaryColor,
        title: "Profile",
        icon: const Icon(
          FontAwesomeIcons.solidUser,
          color: Colors.white,
          size: 15,
        ),
        inactiveIcon: const Icon(
          FontAwesomeIcons.solidUser,
          color: kPrimaryColor,
          size: 15,
        ),
      ),
    ];
  }
}
// Scaffold(
// body: screens[index],
// bottomNavigationBar: CurvedNavigationBar(
// animationDuration: const Duration(milliseconds: 450),
// color: Colors.black,
// buttonBackgroundColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// height: 45,
// items: items,
// onTap: (index) => setState(() {
// this.index = index;
// }),
// ),
// );
