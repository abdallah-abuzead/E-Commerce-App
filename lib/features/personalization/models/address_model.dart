import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/formatters/app_formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formatedPhoneNumber => AppFormatter.formatPhoneNumber(phoneNumber);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': DateTime.now(),
      'selectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) => AddressModel(
    id: data['id'] ?? '',
    name: data['name'] ?? '',
    phoneNumber: data['phoneNumber'] ?? '',
    street: data['street'] ?? '',
    city: data['city'] ?? '',
    state: data['state'] ?? '',
    postalCode: data['postalCode'] ?? '',
    country: data['country'] ?? '',
    dateTime: data['orderDate']?.toDate(),
    selectedAddress: data['selectedAddress'] ?? false,
  );

  factory AddressModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final Map<String, dynamic> data = snapshot.data()!;
      return AddressModel(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        street: data['street'] ?? '',
        city: data['city'] ?? '',
        state: data['state'] ?? '',
        postalCode: data['postalCode'] ?? '',
        country: data['country'] ?? '',
        dateTime: data['orderDate']?.toDate(),
        selectedAddress: data['selectedAddress'] ?? false,
      );
    } else {
      return AddressModel.empty();
    }
  }

  factory AddressModel.empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
  );

  @override
  String toString() => '$street, $city, $state, $postalCode, $country';
}
