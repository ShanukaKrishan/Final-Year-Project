import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/providers/cartProvider.dart';
import 'package:watch_store/shippingScreens/shippingAddressScreen.dart';
import 'package:watch_store/widgets/customButtons.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
          child: cart.itemCount == 0
              ? const Center(child: Text("Nothing to display"))
              : ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CartItemCard(
                      id: cart.cartItems.values.toList()[i].id.toString(),
                      imageUrl: cart.cartItems.values.toList()[i].imageUrl,
                      productId: cart.cartItems.keys.toList()[i],
                      title: cart.cartItems.values.toList()[i].title,
                      price: cart.cartItems.values.toList()[i].price,
                      quantity: cart.cartItems.values.toList()[i].quantity,
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: cart.itemCount == 0
          ? const SizedBox()
          : Container(
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
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
                                  text: cart.totalAmount.toString(),
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontFamily: kDMSerifDisplay)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 190.w,
                          child: CustomButton(
                            buttonText: "CheckOut",
                            press: () => Navigator.pushNamed(
                                context, ShippingAddressScreen.routeName),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;
  final String productId;

  const CartItemCard(
      {Key? key,
      required this.id,
      required this.imageUrl,
      required this.price,
      required this.productId,
      required this.quantity,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          confirmDismiss: (direction) async {
            await CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                backgroundColor: Colors.white,
                title: "Delete all items?",
                confirmBtnText: "Confirm",
                cancelBtnTextStyle: const TextStyle(color: Colors.white),
                confirmBtnColor: const Color.fromRGBO(126, 94, 81, 1),
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  Provider.of<CartProvider>(context, listen: false)
                      .removeItem(productId);
                });
            return null;
          },
          key: ValueKey(id),
          background: Container(
            decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(235, 235, 235, 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(imageUrl, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: kDMSerifDisplay,
                              fontSize: 16,
                            ),
                          ),
                          Text("Total \$${price * quantity}")
                        ],
                      )
                    ],
                  ),
                  Text(quantity.toString() + "x"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
