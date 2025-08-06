import 'package:ecommerce_admin_panel/data/repositories/addresses/addresses_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/popups/app_loaders.dart';

class CustomerDetailsController extends GetxController {
  static CustomerDetailsController get instance => Get.find<CustomerDetailsController>();

  final UserRepository _userRepository = Get.put(UserRepository());
  final AddressesRepository _addressesRepository = Get.put(AddressesRepository());

  RxBool ordersLoading = false.obs;
  RxBool addressesLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  Rx<bool> sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final TextEditingController searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  ///--- Load customer orders
  Future<void> getCustomerOrders() async {
    try {
      ordersLoading.value = true;
      // Fetch customer orders
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders = await _userRepository.fetchUserOrders(customer.value.id!);
      }
      // update the orders list
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      // update the filtered orders list
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      // add all rows as false [not selected] & toggle when required
      selectedRows.assignAll(List.filled(customer.value.orders?.length ?? 0, false));
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  ///--- Load customer addresses
  Future<void> getCustomerAddresses() async {
    try {
      addressesLoading.value = true;
      // Fetch customer addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses = await _addressesRepository.getUserAddresses(customer.value.id!);
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }

  /// search query filter
  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
      allCustomerOrders.where(
        (order) =>
            order.id.toLowerCase().contains(query.toLowerCase()) ||
            order.orderDate.toString().toLowerCase().contains(query.toLowerCase()),
      ),
    );

    update();
  }

  /// Sorting by id
  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredCustomerOrders.sort((a, b) {
      return ascending
          ? a.id.toLowerCase().compareTo(b.id.toLowerCase())
          : b.id.toLowerCase().compareTo(a.id.toLowerCase());
    });
  }
}
