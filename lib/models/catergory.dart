import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CategoryType {
  final String categoryType;
  final String categoryId;
  String imageUrl;
  final String rawPath;
  final bool isMale;

  CategoryType(
      {required this.categoryType,
      required this.rawPath,
      required this.categoryId,
      this.imageUrl = "assets/images/armani-1.jpg",
      this.isMale = false});

  factory CategoryType.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return CategoryType(
      categoryType: snapshot.data()['name'] as String,
      rawPath: snapshot.data()['imagePath'] as String,
      categoryId: snapshot.id,
    );
  }

  Future<void> initialize() async {
    final url = await FirebaseStorage.instance.ref(rawPath).getDownloadURL();
    imageUrl = url;
  }
}
