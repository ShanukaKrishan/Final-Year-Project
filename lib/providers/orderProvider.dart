import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/async.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/models/cartItem.dart';
import 'package:watch_store/models/order.dart';

import 'addressProvider.dart';
import 'cartProvider.dart';

class OrderItem {
  final String id;
  final double amount;
  //final String name;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      // required this.name,
      required this.products,
      required this.dateTime});
}

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  List<Order> _orderHistory = [];
  List<Order> get orderHistory {
    return [..._orderHistory];
  }

  Order getOrderUsingId(String id) {
    return _orderHistory.firstWhere((order) => order.orderId == id);
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: UniqueKey().toString(),
          // name: name,
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now()),
    );
  }

  Future<String> getDocId(
      Future<QuerySnapshot<Map<String, dynamic>>> snapshot) async {
    var docId;
    await snapshot.then(
      (value) {
        value.docs.forEach(
          (element) {
            docId = element.id;
          },
        );
      },
    );
    return docId;
  }

  bool orderFetching = false;

  Future<void> getOrderDetailsFromFirebase() async {
    orderFetching = true;
    final userId = FirebaseAuth.instance.currentUser!.uid;

    //final id = await getDocId(snapshot);

    try {
      final ordersTemp = <Order>[];
      final snapshot = FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();
      await snapshot.then((value) => value.docs.forEach((element) {
            final product = Order.fromFirebase(element);
            ordersTemp.add(product);
          }));
      _orderHistory = ordersTemp;
    } catch (e) {
      print(e);
    } finally {
      orderFetching = false;
    }
    notifyListeners();
    print(_orderHistory.length);
  }
  //
  // Future<void> getOrderedItems() async {
  //   orderFetching = true;
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   try {
  //     final ordersItemsTemp = <CartItem>[];
  //     final snapshot = FirebaseFirestore.instance
  //         .collection('orders')
  //         .where('userId', isEqualTo: userId)
  //         .get();
  //
  //     final sd = await snapshot.then((value) => value.size);
  //     print(sd);
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     orderFetching = false;
  //   }
  // }

  Future<void> sendOrder(BuildContext context) async {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final addressProvider =
        Provider.of<UserAddress>(context, listen: false).address;
    cart.cartItems.forEach((key, value) {
      print(value.productId);
    });

    final user = FirebaseAuth.instance.currentUser;
    final productItems = [];
    for (final item in cart.cartItems.values) {
      productItems.add({
        'productId': item.productId,
        'imageUrl': item.imageUrl,
        'productTitle': item.title,
        'itemPrice': item.price,
        'quantity': item.quantity,
      });
    }

    await FirebaseFirestore.instance.collection("orders").add({
      'orderId': UniqueKey().toString(),
      'userId': user!.uid,
      'totalPaid': cart.totalAmount.toString(),
      'customerEmail': user.email.toString(),
      'phone': addressProvider[0].phone.toString(),
      'country': addressProvider[0].country,
      'addressOne': addressProvider[0].addressOne,
      'addressTwo': addressProvider[0].addressTwo,
      'zipCode': addressProvider[0].zipCode,
      'orderDate': DateFormat.yMMMd('en_US').format(DateTime.now()),
      'orderStatus': 'Pending',
      'products': productItems,
    }).then((value) => cart.cartItems);
    //     .then((value) {
    //   cart.cartItems.forEach((key, item) {
    //     print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    //     print(value.id);
    //     value.collection('orders').add({
    //       'userId': user.uid,
    //       'cartId': item.id,
    //       'productImage': item.imageUrl,
    //       'productId': item.productId,
    //       'productPrice': item.price,
    //       'productTitle': item.title,
    //       'quantity': item.quantity.toString(),
    //     });
    //   });
    // }).then((value) => cart.clearCart());
  }
}
