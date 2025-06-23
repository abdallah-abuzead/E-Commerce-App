import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find<UserController>();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final UserRepository userRepository = Get.put(UserRepository());

  @override
  onInit() async {
    await fetchUserDetails();
    super.onInit();
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final UserModel user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      AppLoaders.errorSnackBar(
        title: 'Something went wrong',
        message: e.toString(),
      );
      return UserModel.empty();
    }
  }
}
