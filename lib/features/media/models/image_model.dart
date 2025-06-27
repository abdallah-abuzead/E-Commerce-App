import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../utils/formatters/app_formatter.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localeImageToDisplay;

  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    required this.fileName,
    this.sizeBytes,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localeImageToDisplay,
    this.mediaCategory = '',
  });

  /// static method to create an empty ImageModel
  static ImageModel empty() => ImageModel(url: '', folder: '', fileName: '');

  String get createdAtFormatted => AppFormatter.formatDate(createdAt);

  String get updatedAtFormatted => AppFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'fileName': fileName,
      'fullPath': fullPath,
      'createdAt': createdAt?.toIso8601String(),
      'contentType': contentType,
      'mediaCategory': mediaCategory,
    };
  }

  /// convert Firestore DocumentSnapshot to ImageModel
  factory ImageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      final Map<String, dynamic> data = document.data()!;
      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        fileName: data['fileName'] ?? '',
        fullPath: data['fullPath'] ?? '',
        createdAt: data['createdAt']?.toDate(),
        updatedAt: data['updatedAt']?.toDate(),
        contentType: data['contentType'] ?? '',
        mediaCategory: data['mediaCategory'] ?? '',
      );
    } else {
      return empty();
    }
  }

  /// Map Firebase storage metadata to ImageModel
  factory ImageModel.fromFirebaseMetadata(
    FullMetadata metadata,
    String folder,
    String fileName,
    String downloadUrl,
  ) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      fileName: fileName,
      sizeBytes: metadata.size,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      updatedAt: metadata.updated,
      contentType: metadata.contentType,
    );
  }
}
