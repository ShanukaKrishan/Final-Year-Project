import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/catergory.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryType> _categories = [
    // CategoryType(
    //     categoryType: "Leather Watch",
    //     categoryId: '1',
    //     categoryImageUrl: "assets/images/black-watch.jpg"),
    // CategoryType(
    //     categoryType: "Metallic watch",
    //     categoryId: '2',
    //     categoryImageUrl: "assets/images/black-dial-silver-watch.jpg"),
    // CategoryType(
    //     categoryType: "Smart Watch",
    //     categoryId: '3',
    //     categoryImageUrl: "assets/images/smart-watch.jpg"),
  ];
  List<CategoryType> get categories {
    return [..._categories];
  }

  bool productsFetching = true;
  CategoryType getCategoryUsingId(String id) {
    return _categories.firstWhere((category) => category.categoryId == id);
  }

  Future<void> getCategoriesFromFirebase() async {
    productsFetching = true;
    try {
      final categorys = <CategoryType>[];
      final categorySnapshots =
          await FirebaseFirestore.instance.collection('categories').get();
      for (final snapshot in categorySnapshots.docs) {
        print(snapshot.data());

        final category = CategoryType.fromFirebase(snapshot);
        await category.initialize();

        categorys.add(category);
      }
      _categories = categorys;
    } catch (e) {
      print(e);
    } finally {
      productsFetching = false;
    }
    notifyListeners();
  }
}
