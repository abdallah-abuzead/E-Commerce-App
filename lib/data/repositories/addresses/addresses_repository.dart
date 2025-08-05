import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/data/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/address_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceprions.dart';
import '../../../utils/exceptions/format_exeptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AddressesRepository extends GetxController {
  static AddressesRepository get instance => Get.find<AddressesRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createAddress(AddressModel address) async {
    try {
      final String userId = AuthRepository.instance.authUser!.uid;
      final createdAddress = await _db
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .add(address.toJson());
      return createdAddress.id;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<List<AddressModel>> getUserAddresses(String userId) async {
    try {
      final snapshot = await _db.collection('users').doc(userId).collection('addresses').get();
      return snapshot.docs.map((doc) => AddressModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  /// Update the selected address field
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final String userId = AuthRepository.instance.authUser!.uid;
      final createdAddress = await _db
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
