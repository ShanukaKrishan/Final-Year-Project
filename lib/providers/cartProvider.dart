import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/models/cartItem.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
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
              title: existingCartItem.title,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
      notifyListeners();
    } else {
      showCustomAlert(context, "Product Added To Cart");
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            imageUrl: imageUrl,
            quantity: 1,
            price: price),
      );
      notifyListeners();
    }
  }

  void removeOneItem(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            imageUrl: existingCartItem.imageUrl,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price));
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
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
      confirmBtnColor: Color.fromRGBO(126, 94, 81, 1),
      onConfirmBtnTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, CartScreen.routeName);
      },
      onCancelBtnTap: () => Navigator.pop(context));
}
