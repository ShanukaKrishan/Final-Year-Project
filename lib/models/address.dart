import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_store/providers/addressProvider.dart';

class AddressModel {
  final String addressOne;
  String addressTwo;
  final String zipCode;
  final String country;
  final String userId;
  final String phone;
  AddressModel(
      {required this.addressOne,
      this.addressTwo = '',
      required this.zipCode,
      required this.country,
      required this.userId,
      required this.phone});

  factory AddressModel.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return AddressModel(
        addressOne: snapshot.data()['addressOne'],
        addressTwo: snapshot.data()['addressTwo'],
        zipCode: snapshot.data()['zipCode'],
        country: snapshot.data()['country'],
        userId: snapshot.data()['userId'],
        phone: snapshot.data()['phone']);
  }
}
