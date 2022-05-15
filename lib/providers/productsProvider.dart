import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _arItems = [
    Product(
        id: '23',
        title: 'Siko',
        description: "Blue leather Siko watch with black dial",
        price: 200,
        brand: 'Siko',
        categoryId: '',
        imagePath:
            'https://firebasestorage.googleapis.com/v0/b/ar-watch-store-e169b.appspot.com/o/products%2F1.png?alt=media&token=ef799073-045a-4723-aed7-29c86b11d9ba',
        imageUrl: 'assets/images/w1.png',
        category: 'Leather Watch'),
    Product(
        id: '24',
        title: 'Armani',
        description: "Black leather watch with a black dial for every outfit",
        price: 600,
        brand: 'Armani',
        categoryId: '',
        imagePath: '',
        imageUrl: 'assets/images/w2.png',
        category: 'Leather Watch'),
    Product(
        id: '25',
        title: 'Tissot',
        description: "Metallic watch for formal wear with a ocean blue dial",
        price: 700,
        categoryId: '',
        imagePath: '',
        brand: 'Tissot',
        imageUrl: 'assets/images/w3.png',
        category: 'Metallic Strap'),
  ];

  List<Product> get arItems {
    return [..._arItems];
  }

  List favorites = [];

  // final List<Product> _items = [
  //   Product(
  //       id: 1,
  //       brand: "Armani",
  //       category: "Leather Watch",
  //       title: 'Armani',
  //       description: "",
  //       price: 400,
  //       isAr: true,
  //       isFeatured: true,
  //       imageUrl: "assets/images/offSilver-watch.jpg"),
  //   Product(
  //     id: 2,
  //     brand: "lux",
  //     category: "Metallic Strap",
  //     title: 'Lux Hero',
  //     description: "",
  //     price: 500,
  //     isFeatured: true,
  //     isAr: true,
  //     imageUrl: "assets/images/gold-metal-watch.jpg",
  //   ),
  //   Product(
  //       category: "Metallic Strap",
  //       brand: "tissot",
  //       id: 3,
  //       title: 'Tissot',
  //       description: "",
  //       price: 600,
  //       isFeatured: true,
  //       imageUrl: "assets/images/goldrose-metal-watch.jpg"),
  //   Product(
  //     id: 4,
  //     brand: "Paul",
  //     category: "Metallic Strap",
  //     title: 'Paul',
  //     description: "",
  //     price: 700,
  //     isFeatured: false,
  //     imageUrl: "assets/images/silver-metal-watch.jpg",
  //   ),
  //   Product(
  //       id: 5,
  //       brand: "Paul",
  //       category: "Metallic Strap",
  //       title: 'Lumix',
  //       description: "",
  //       price: 700,
  //       isFeatured: false,
  //       imageUrl: "assets/images/silver-metal-watch.jpg"),
  //   Product(
  //       id: 6,
  //       brand: "ginger",
  //       category: "Metallic Strap",
  //       title: 'Robert Wood',
  //       description: "",
  //       price: 100,
  //       isFeatured: false,
  //       imageUrl: "assets/images/rosegold-metallic-watch.jpg"),
  //   Product(
  //       id: 7,
  //       brand: "Armani",
  //       category: "Leather Strap",
  //       title: "Armani",
  //       description: "",
  //       price: 100,
  //       isFeatured: true,
  //       imageUrl: "assets/images/armani-3.jpg"),
  // ];

  List<Product> _items = [];

  bool productsFetching = true;

  List<Product> get items {
    return [..._items];
  }

  List<Product> catogrizedProducts(String cat) {
    var categoryItems;
    categoryItems = _items.where((element) => element.category == cat);
    return categoryItems;
  }

  Product getProductUsingId(int id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Product getProductUsingStringId(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Product getProductUsingTitle(String title) {
    return _items.firstWhere(
        (product) => product.title.toString() == title.toLowerCase());
  }

  Product getArProductUsingId(String id) {
    return _arItems.firstWhere((product) => product.id == id);
  }

  void addProduct() {
    //_items.add();
    notifyListeners();
  }

  Future<void> getProductsFromFirebase() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    productsFetching = true;
    try {
      final products = <Product>[];

      final productsSnapshots =
          await FirebaseFirestore.instance.collection('products').get();

      for (final snapshot in productsSnapshots.docs) {
        if (snapshot.exists) {
          final favorite = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('favorites')
              .doc(snapshot.id)
              .get();
          final product = Product.fromFirebase(snapshot, favorite);
          await product.initialize();

          products.add(product);
        }
        print(snapshot.data());
      }

      _items = products;
    } catch (e) {
      print(e);
    } finally {
      productsFetching = false;
    }
    notifyListeners();
  }

  Future<void> getFavorites() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final tempFavorite = [];
    final favoriteProducts = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    final productsSnapshots =
        await FirebaseFirestore.instance.collection('products').get();
    bool isFavorite = false;
    for (final snapshot in productsSnapshots.docs) {
      favoriteProducts.docs.forEach((element) {
        print(element.id);
        if (snapshot.id == element.id) {
          if (element.data()[snapshot.id]) {
            tempFavorite.add(element.id);
            isFavorite = element.get(snapshot.id);
          }
        }
        favorites = tempFavorite;
      });
    }
    notifyListeners();
  }
}
