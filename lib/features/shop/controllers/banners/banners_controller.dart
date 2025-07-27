import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/app_base_controller.dart';
import '../../../../data/repositories/banners/banners_repository.dart';

class BannersController extends AppBaseController<BannerModel> {
  static BannersController get instance => Get.find<BannersController>();

  final BannersRepository _bannersRepository = Get.put(BannersRepository());

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannersRepository.getAllBanners();
  }

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannersRepository.deleteBanner(item.id!);
  }

  /// method for formatting a route string
  String formatRoute(String route) {
    if (route.isEmpty) return '';
    // Remove the leading '/'
    String formatted = route.substring(1);
    // Capitalize the first letter of each word
    formatted = formatted.capitalizeFirst.toString();
    return formatted;
  }

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }
}
