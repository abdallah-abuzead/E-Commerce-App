import 'package:ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/app_base_controller.dart';
import '../../../../data/repositories/user/user_repository.dart';

class CustomersController extends AppBaseController<UserModel> {
  static CustomersController get instance => Get.find<CustomersController>();

  final UserRepository _userRepository = Get.put(UserRepository());

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (customer) => customer.fullName.toLowerCase());
  }

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _userRepository.deleteUser(item.id ?? '');
  }

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _userRepository.getAllUsers();
  }
}
