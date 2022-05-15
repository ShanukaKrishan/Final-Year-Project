import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String? category;
  final String categoryId;
  final String description;
  final num price;
  String imageUrl;
  final String imagePath;
  final String brand;
  bool isFavorite;
  bool isAr;
  bool isFeatured;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
    this.imageUrl = "assets/images/armani-1.jpg",
    required this.imagePath,
    this.category,
    required this.categoryId,
    this.isFavorite = false,
    this.isFeatured = false,
    this.isAr = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  // Future<void> checkStatus(String productId) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   final favoriteProducts = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('favorites')
  //       .doc(productId)
  //       .get();
  //   isFavorite = favoriteProducts.data()![productId];
  //   print(favoriteProducts.get(productId) ?? "sss");
  // }

  factory Product.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
      DocumentSnapshot favorite) {
    print(snapshot.data()['name']);
    print("xxxxxxxxxx");
    return Product(
        id: snapshot.id,
        category: snapshot.data()['categoryId'] as String,
        title: snapshot.data()['name'] as String,
        description: snapshot.data()['description'] as String,
        price: snapshot.data()['price'] as num,
        isFeatured: snapshot.data()['featured'] as bool,
        brand: snapshot.data()['brandId'] as String,
        isFavorite: favorite.exists ? favorite.get(snapshot.id) : false,
        categoryId: snapshot.data()['categoryId'] as String,
        imagePath: snapshot.data()["imagePaths"][0] as String);
  }

  Future<void> initialize() async {
    final url = await FirebaseStorage.instance.ref(imagePath).getDownloadURL();
    imageUrl = url;
  }

  // Future<void> assignFavorites(String productId) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   final favoriteProducts = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('favorites')
  //       .where(productId)
  //       .get();
  //   if (favoriteProducts.docs.first.exists) {
  //     isFavorite = favoriteProducts.docs.first.get(productId);
  //   }
  // }

  Future<void> togleFavoriteStatus(String productId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    isFavorite = !isFavorite;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(productId)
        .set({productId: isFavorite});
  }
}
