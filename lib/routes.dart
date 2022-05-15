import 'package:flutter/material.dart';
import 'package:watch_store/3DViewProductDetailScreen/3DViewScreen.dart';
import 'package:watch_store/OrderDetailScreen/orderDetailScreen.dart';
import 'package:watch_store/categoryScreen/categoryScreen.dart';
import 'package:watch_store/chatScreen/chatScreen.dart';
import 'package:watch_store/forgotScreen/CheckEmailScreen.dart';
import 'package:watch_store/forgotScreen/forgotScreen.dart';
import 'package:watch_store/main.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryDetailScreen.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryScreen.dart';
import 'package:watch_store/paymentScreen/paymentScreen.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/profileScreen/passwordMangerScreen.dart';
import 'package:watch_store/shippingScreens/shippingAddressFormScreen.dart';
import 'package:watch_store/stripeScreen/stripeScreen.dart';
import 'package:watch_store/widgets/verifyEmailScreen.dart';
import 'cartScreen/cartScreen.dart';
import 'loginScreen/loginScreen.dart';
import 'registerScreen/registerScreen.dart';
import 'homeScreen/homeScreen.dart';
import 'profileScreen/profileScreen.dart';
import 'wishListScreen/wishListScreen.dart';
import 'shippingScreens/shippingAddressScreen.dart';
import 'allProductScreen/allProductScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  ForgotScreen.routeName: (context) => const ForgotScreen(),
  CheckEmailScreen.routeName: (context) => const CheckEmailScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  WishListScreen.routeName: (context) => const WishListScreen(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
  ShippingAddressScreen.routeName: (context) => const ShippingAddressScreen(),
  PaymentScreen.routeName: (context) => const PaymentScreen(),
  OrderDetailScreen.routeName: (context) => const OrderDetailScreen(),
  AllProductScreen.routeName: (context) => const AllProductScreen(),
  CategoryScreen.routeName: (context) => const CategoryScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),
  OrderHistoryScreen.routeName: (context) => const OrderHistoryScreen(),
  StartPoint.routeName: (context) => const StartPoint(),
  PaymentGateWay.routeName: (context) => const PaymentGateWay(),
  CategoryScreen.routeName: (context) => const CategoryScreen(),
  ARViewScreen.routeName: (context) => const ARViewScreen(),
  OrderHistoryDetail.routeName: (context) => const OrderHistoryDetail(),
  PasswordScreen.routeName: (context) => PasswordScreen(),
  AddressForm.routeName: (context) => const AddressForm(),
};
