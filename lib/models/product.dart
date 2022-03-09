import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final int id;
  final String title;
  final String category;
  final String description;
  final double price;
  final String imageUrl;
  final String brand;
  bool isFavorite;
  bool isAr;
  bool isFeatured;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.brand,
      required this.imageUrl,
      required this.category,
      this.isFavorite = false,
      this.isFeatured = false,
      this.isAr = false});
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
