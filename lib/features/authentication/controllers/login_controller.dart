import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  final Rx<bool> hidePassword = true.obs;
  final Rx<bool> rememberMe = false.obs;
  final GetStorage localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  onInit() {
    super.onInit();
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    // rememberMe.value = true;
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in ...', AppImages.docerAnimation);
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // if remember me is checked, save email and password to local storage
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      await AuthRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // fetch the user from Firestore and assign it to user controller
      final UserModel user = await UserController.instance.fetchUserDetails();

      FullScreenLoader.stopLoadingDialog();

      if (user.role != AppRole.admin) {
        await AuthRepository.instance.logout();
        AppLoaders.errorSnackBar(
          title: 'Not Authorized',
          message:
              'Yor are not authorized or do have access. '
              'Please contact the admin.',
        );
      } else {
        AuthRepository.instance.screenRedirect();
      }
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> registerAdmin() async {
    try {
      FullScreenLoader.openLoadingDialog('Registering Admin Account...', AppImages.docerAnimation);

      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // if (!loginFormKey.currentState!.validate()) {
      //   FullScreenLoader.stopLoadingDialog();
      //   return;
      // }
      await AuthRepository.instance.registerWithEmailAndPassword(
        AppStrings.adminEmail,
        AppStrings.password,
      );

      // create the admin user in Firestore
      final UserRepository userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthRepository.instance.authUser!.uid,
          firstName: 'CwT',
          lastName: 'Admin',
          email: AppStrings.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      FullScreenLoader.stopLoadingDialog();

      AuthRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
