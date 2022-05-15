import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/OrderDetailScreen/orderDetailScreen.dart';
import 'package:watch_store/models/cartItem.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:watch_store/shippingScreens/shippingAddressScreen.dart';

class CartProvider with ChangeNotifier {
  // void sendData() {
  //   var params = jsonEncode({"total": cart.totalAmount.toString()});
  //   AlanVoice.callProjectApi("script::getTotal", params);
  // }

  Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addItem(String productId, double price, String title, String imageUrl,
      BuildContext context) {
    if (_cartItems.containsKey(productId)) {
      showCustomAlert(context, "Product Updated");

      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              productId: productId,
              title: existingCartItem.title,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
      var params = jsonEncode({"total": totalAmount.toString()});
      AlanVoice.callProjectApi("script::getTotal", params);
      notifyListeners();
    } else {
      showCustomAlert(context, "Product Added To Cart");
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
            id: UniqueKey().toString(),
            productId: productId,
            title: title,
            imageUrl: imageUrl,
            quantity: 1,
            price: price),
      );
      var params = jsonEncode({"total": totalAmount.toString()});
      AlanVoice.callProjectApi("script::getTotal", params);
      // Navigator.popAndPushNamed(context, CartScreen.routeName);

      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            productId: existingCartItem.productId,
            title: existingCartItem.title,
            imageUrl: existingCartItem.imageUrl,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price));

    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    var params = jsonEncode({"total": totalAmount.toString()});
    AlanVoice.callProjectApi("script::getTotal", params);
    notifyListeners();
  }

  int get totalAmount {
    int total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price.toInt() * cartItem.quantity;
    });

    return total;
  }

  int get itemCount {
    return _cartItems.length;
  }
}

void showCustomAlert(BuildContext context, String title) {
  CoolAlert.show(
      context: context,
      showCancelBtn: true,
      title: title,
      type: CoolAlertType.success,
      cancelBtnText: "Back",
      confirmBtnText: "View cart",
      // confirmBtnColor: Colors.green,
      width: 100,
      backgroundColor: Colors.white,
      cancelBtnTextStyle: const TextStyle(
        color: Colors.white,
      ),
      confirmBtnColor: const Color.fromRGBO(126, 94, 81, 1),
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
      onConfirmBtnTap: () {
        Navigator.pop(context);
        pushNewScreen(
          context,
          screen: CartScreen(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      });
}
