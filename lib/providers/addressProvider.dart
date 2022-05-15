import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:watch_store/models/address.dart';

class UserAddress with ChangeNotifier {
  List<AddressModel> _address = [];
  List<AddressModel> get address {
    return [..._address];
  }

  Future<void> deleteAddress(String userID) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userAddress')
        .where('userId', isEqualTo: userID)
        .get()
        .then((res) => res.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userID)
                  .collection('userAddress')
                  .doc(element.id)
                  .delete();
            }));
    _address.clear();
    notifyListeners();
  }

  bool addressFetching = true;
  Future<void> getAddressFromFirebase() async {
    addressFetching = true;
    _address.clear();
    final userID = FirebaseAuth.instance.currentUser!.uid;

    try {
      final addresses = <AddressModel>[];
      final userAddressSnapShots = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('userAddress')
          .get();

      final address = AddressModel.fromFirebase(userAddressSnapShots.docs[0]);
      addresses.add(address);

      _address = addresses;
    } catch (e) {
      print(e);
    } finally {
      addressFetching = false;
    }
    notifyListeners();
    // return _address;
  }

  Future<void> saveAddress(String addressOne, String addressTwo, String zipCode,
      String country, String phone) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final userAddress = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userAddress')
        .get();

    print(userAddress);
    if (userAddress.size == 0) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('userAddress')
          .add({
        'addressOne': addressOne,
        'addressTwo': addressTwo,
        'zipCode': zipCode,
        'userId': userID,
        'country': country,
        'phone': phone,
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('userAddress')
          .where('userId', isEqualTo: userID)
          .get()
          .then((res) => res.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(userID)
                    .collection('userAddress')
                    .doc(element.id)
                    .update({
                  'addressOne': addressOne,
                  'addressTwo': addressTwo,
                  'country': country,
                  'phone': phone,
                  'zipCode': zipCode,
                });
              }));
    }
    notifyListeners();
  }
}
