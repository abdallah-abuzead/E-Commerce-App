import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/address_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/formatters/app_formatter.dart';

class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final AppRole role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses;

  UserModel({
    this.id,
    this.firstName = '',
    required this.email,
    this.lastName = '',
    this.username = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
    // this.orders,
    // this.addresses,
  });

  // static method to create an empty user model
  static UserModel empty() => UserModel(email: '');

  /// Helper methods
  String get fullName => '$firstName $lastName'.trim();

  String get formatedCreatedDate => AppFormatter.formatDate(createdAt);

  String get formatedUpdatedDate => AppFormatter.formatDate(updatedAt);

  String get formatedPhoneNo => AppFormatter.formatPhoneNumber(phoneNumber);

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role.name.toString(),
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final Map<String, dynamic> data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        role: AppRole.values.firstWhere(
          (e) => e.name == (data['role'] ?? AppRole.user.name),
          orElse: () => AppRole.user,
        ),
        createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
        updatedAt: data['updatedAt']?.toDate() ?? DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
