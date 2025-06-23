import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find<UserController>();

  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final UserRepository userRepository = Get.put(UserRepository());

  Future<UserModel> fetchUserDetails() async {
    try {
      return await userRepository.fetchAdminDetails();
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: 'Something went wrong',
        message: e.toString(),
      );
      return UserModel.empty();
    }
  }
}
