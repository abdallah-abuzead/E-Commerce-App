import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? id;
  String imageUrl;
  bool active;
  String targetScreen;

  BannerModel({this.id, required this.imageUrl, required this.active, required this.targetScreen});

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl, 'active': active, 'targetScreen': targetScreen};
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return BannerModel(
        id: document.id,
        imageUrl: data['imageUrl'] ?? '',
        active: data['active'] ?? false,
        targetScreen: data['targetScreen'] ?? '',
      );
    } else {
      return BannerModel.empty();
    }
  }

  factory BannerModel.empty() => BannerModel(imageUrl: '', active: false, targetScreen: '');
}
