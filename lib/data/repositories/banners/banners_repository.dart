import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceprions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';

class BannersRepository extends GetxController {
  static BannersRepository get instance => Get.find<BannersRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all Banners from 'banners' collection
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.collection('banners').get();
      return snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> deleteBanner(String id) async {
    try {
      await _db.collection('banners').doc(id).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<String> createBanner(BannerModel newRecord) async {
    try {
      final data = await _db.collection('banners').add(newRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  Future<void> updateBanner(BannerModel banner) async {
    try {
      await _db.collection('banners').doc(banner.id).update(banner.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
