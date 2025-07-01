import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/media/models/image_model.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find<MediaRepository>();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImageModel> uploadImageFileInStorage({
    required dynamic file,
    required String path,
    required String imageName,
  }) async {
    try {
      final Reference ref = _storage.ref().child('$path/$imageName');
      await ref.putBlob(file);
      final String downloadUrl = await ref.getDownloadURL();
      final FullMetadata metaData = await ref.getMetadata();
      return ImageModel.fromFirebaseMetadata(metaData, path, imageName, downloadUrl);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance.collection('images').add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
