import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/media/models/image_model.dart';
import '../../../utils/constants/appwrite.dart';

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

  Future<ImageModel> uploadImageFileInAppwrite({
    required List<int> fileBytes,
    required String folder,
    required String imageName,
  }) async {
    try {
      final file = await Appwrite.storage.createFile(
        bucketId: Appwrite.mediaBucketId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(bytes: fileBytes, filename: '$folder/$imageName'),
      );
      final String downloadUrl = Appwrite.getDownloadURL(file.bucketId, file.$id);
      return ImageModel.fromAppwriteMetadata(
        folder: folder,
        fileName: imageName,
        downloadUrl: downloadUrl,
        size: file.sizeOriginal,
        createdAt: file.$createdAt,
        updatedAt: file.$updatedAt,
      );
    } on AppwriteException catch (e) {
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
