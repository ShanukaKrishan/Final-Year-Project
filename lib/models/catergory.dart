import 'package:flutter/material.dart';

class CategoryType {
  final String categoryType;
  final int categoryId;
  final String categoryImageUrl;
  final bool isMale;

  CategoryType(
      {required this.categoryType,
      required this.categoryId,
      required this.categoryImageUrl,
      this.isMale = false});
}
