import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/paymentScreen/paymentScreen.dart';
import 'package:watch_store/providers/addressProvider.dart';
import 'package:watch_store/providers/cartProvider.dart';
import 'package:watch_store/providers/productsProvider.dart';
import 'package:watch_store/shippingScreens/shippingAddressScreen.dart';
import 'package:watch_store/widgets/customButtons.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/product.dart';
import '../widgets/CartCard.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //
  // Future<void> getCartItems(BuildContext context) async {
  //   final userID = FirebaseAuth.instance.currentUser!.uid;
  //
  //   final find = Provider.of<ProductsProvider>(context);
  //   final cartSnapShots = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userID)
  //       .collection('userCart')
  //       .get();
  //   for (final snapshot in cartSnapShots.docs) {
  //     print(snapshot.data()['productId']);
  //     print(snapshot.data()['price']);
  //
  //     products.add(find.getProductUsingStringId(snapshot.data()['productId']));
  //
  //     // products.add(find.getProductUsingStringId(snapshot.id));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverAppBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "CART",
                    style: kTextAppBarTitle,
                  ),
                )
              ];
            },
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: cartItems.cartItems.length == 0
                  ? const Center(child: Text("Nothing to display"))
                  : Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartItems.cartItems.length,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: CartItemCard(
                              id: cartItems.cartItems.values.toList()[i].id,
                              imageUrl: cartItems.cartItems.values
                                  .toList()[i]
                                  .imageUrl,
                              productId:
                                  cartItems.cartItems.values.toList()[i].id,
                              title:
                                  cartItems.cartItems.values.toList()[i].title,
                              price:
                                  cartItems.cartItems.values.toList()[i].price,
                              quantity: cartItems.cartItems.values
                                  .toList()[i]
                                  .quantity,
                            ),
                          ),
                        ),
                      ],
                    ),
            )),
        bottomNavigationBar: cartItems.cartItems.length == 0
            ? const SizedBox()
            : buildBottomBar(context, cartItems.totalAmount.toString()));
  }

  Container buildBottomBar(BuildContext context, String total) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADDADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    text: "Total \n",
                    style: const TextStyle(
                      fontFamily: kDMSerifDisplay,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                          text: '\$' + total,
                          style: const TextStyle(
                              fontSize: 22, fontFamily: kDMSerifDisplay)),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: kPrimaryColor,
                      fixedSize: Size(200, 50),
                      maximumSize: Size(250, 100),
                    ),
                    onPressed: () {
                      Provider.of<UserAddress>(context, listen: false)
                          .getAddressFromFirebase();
                      pushNewScreen(context,
                          screen: const ShippingAddressScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino);
                    },
                    child: const Text("CheckOut"))
                // SizedBox(
                //   width: 190.w,
                //   child: CustomButton(
                //     buttonText: "CheckOut",
                //     press: () => pushNewScreen(
                //       context,
                //       screen: const ShippingAddressScreen(),
                //       withNavBar: true, // OPTIONAL VALUE. True by default.
                //       pageTransitionAnimation:
                //           PageTransitionAnimation.cupertino,
                //     ),
                //     // press: () => Navigator.pushNamed(
                //     //     context, ShippingAddressScreen.routeName),
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
