import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exeptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find<SettingsRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save data to firestore
  Future<void> registerSettings(SettingsModel settings) async {
    try {
      await _db.collection('settings').doc('GLOBAL_SETTINGS').set(settings.toJson());
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  // Get Settings details based on settings id
  Future<SettingsModel> getSettings() async {
    try {
      final snapshot = await _db.collection('settings').doc('GLOBAL_SETTINGS').get();
      return SettingsModel.fromSnapshot(snapshot);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  // update Settings details
  Future<void> updateSettingsDetails(SettingsModel settings) async {
    try {
      await _db.collection('settings').doc('GLOBAL_SETTINGS').update(settings.toJson());
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }

  //   // update single filed in any specific Settings collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection('settings').doc('GLOBAL_SETTINGS').update(json);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw AppFormatException();
    } catch (e) {
      throw ('Something went wrong. Please try again');
    }
  }
}
