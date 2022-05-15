import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
      {required this.id,
      required this.productId,
      required this.imageUrl,
      required this.title,
      required this.quantity,
      required this.price});

  // factory CartItem.fromFirebase(List<CartItem> items) {
  //   final List<CartItem> orderHistoryItems = [];
  //   for (final item in items) {
  //     orderHistoryItems.add(item.)
  //   }
  //
  // }
}
