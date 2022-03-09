import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 1,
        brand: "timex",
        category: "Leather Watch",
        title: 'Armani',
        description: "",
        price: 400,
        isAr: true,
        isFeatured: true,
        imageUrl: "assets/images/offSilver-watch.jpg"),
    Product(
        id: 2,
        brand: "lux",
        category: "Metallic Watch",
        title: 'Rolex',
        description: "",
        price: 500,
        isFeatured: true,
        isAr: true,
        imageUrl: "assets/images/gold-metal-watch.jpg"),
    Product(
        category: "Metallic Watch",
        brand: "lux",
        id: 3,
        title: 'Tissot',
        description: "",
        price: 600,
        isFeatured: true,
        imageUrl: "assets/images/goldrose-metal-watch.jpg"),
    Product(
        id: 4,
        brand: "paul",
        category: "Metallic Watch",
        title: 'TimeX',
        description: "",
        price: 700,
        isFeatured: false,
        imageUrl: "assets/images/silver-metal-watch.jpg"),
    Product(
        id: 5,
        brand: "paul",
        category: "Metallic Watch",
        title: 'Lumix',
        description: "",
        price: 700,
        isFeatured: false,
        imageUrl: "assets/images/silver-metal-watch.jpg"),
    Product(
        id: 6,
        brand: "ginger",
        category: "Metallic Watch",
        title: 'Robert Wood',
        description: "",
        price: 100,
        isFeatured: false,
        imageUrl: "assets/images/rosegold-metallic-watch.jpg"),
    Product(
        id: 7,
        brand: "Armani",
        category: "Leather belt",
        title: "Armani Emperior",
        description: "",
        price: 100,
        isFeatured: true,
        imageUrl: "assets/images/armani-3.jpg"),
  ];
  List<Product> get items {
    return [..._items];
  }

  Product getProductUsingId(int id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProduct() {
    //_items.add();
    notifyListeners();
  }
}
