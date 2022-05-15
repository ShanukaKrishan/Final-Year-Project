import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/models/cartItem.dart';

class Order {
  final String orderDate;
  final String orderStatus;
  final String orderId;
  final String addressOne;
  final String addressTwo;
  final String zipCode;
  final String email;
  final String phone;
  final String country;
  final String totalPaid;
  final List<dynamic> products;

  Order(
      {required this.orderDate,
      required this.orderStatus,
      required this.orderId,
      required this.email,
      required this.addressOne,
      required this.addressTwo,
      required this.zipCode,
      required this.phone,
      required this.country,
      required this.products,
      required this.totalPaid});

  factory Order.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Order(
      orderDate: snapshot.data()['orderDate'] as String,
      orderStatus: snapshot.data()['orderStatus'] as String,
      addressOne: snapshot.data()['addressOne'] as String,
      addressTwo: snapshot.data()['addressTwo'] as String,
      country: snapshot.data()['country'] as String,
      email: snapshot.data()['customerEmail'] as String,
      phone: snapshot.data()['phone'] as String,
      zipCode: snapshot.data()['zipCode'] as String,
      orderId: snapshot.data()['orderId'] as String,
      products: snapshot.data()['products'] as List<dynamic>,
      totalPaid: snapshot.data()['totalPaid'] as String,
    );
  }
}
