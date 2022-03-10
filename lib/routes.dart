import 'package:flutter/material.dart';
import 'package:watch_store/OrderDetailScreen/orderDetailScreen.dart';
import 'package:watch_store/forgotScreen/CheckEmailScreen.dart';
import 'package:watch_store/forgotScreen/forgotScreen.dart';
import 'package:watch_store/paymentScreen/paymentScreen.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/widgets/verifyEmailScreen.dart';
import 'cartScreen/cartScreen.dart';
import 'loginScreen/loginScreen.dart';
import 'registerScreen/registerScreen.dart';
import 'homeScreen/homeScreen.dart';
import 'profileScreen/profileScreen.dart';
import 'wishListScreen/wishListScreen.dart';
import 'shippingScreens/shippingAddressScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  ForgotScreen.routeName: (context) => const ForgotScreen(),
  CheckEmailScreen.routeName: (context) => const CheckEmailScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  WishListScreen.routeName: (context) => const WishListScreen(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
  ShippingAddressScreen.routeName: (context) => const ShippingAddressScreen(),
  PaymentScreen.routeName: (context) => const PaymentScreen(),
  OrderDetailScreen.routeName: (context) => const OrderDetailScreen(),
};
