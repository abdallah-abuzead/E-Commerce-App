import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  SettingsModel({
    this.id,
    this.taxRate = 0,
    this.shippingCost = 0,
    this.freeShippingThreshold,
    this.appName = '',
    this.appLogo = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'taxRate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'appName': appName,
      'appLogo': appLogo,
    };
  }

  factory SettingsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final Map<String, dynamic> data = snapshot.data()!;
      return SettingsModel(
        id: snapshot.id,
        taxRate: data['taxRate']?.toDouble() ?? 0,
        shippingCost: data['shippingCost']?.toDouble() ?? 0,
        freeShippingThreshold: data['freeShippingThreshold']?.toDouble() ?? 0,
        appName: data['appName'] ?? '',
        appLogo: data['appLogo'] ?? '',
      );
    } else {
      return SettingsModel.empty();
    }
  }

  factory SettingsModel.empty() => SettingsModel();
}
