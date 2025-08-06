import 'package:ecommerce_admin_panel/common/widgets/images/app_circular_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/personalization/controllers/settings_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/enums.dart';
import 'menu/app_menu_item.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;

    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(right: BorderSide(color: AppColors.grey)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    AppCircularImage(
                      width: 45,
                      height: 45,
                      padding: 0,
                      margin: AppSizes.sm,
                      backgroundColor: Colors.transparent,
                      imageType: controller.settings.value.appLogo.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                      image: controller.settings.value.appLogo.isNotEmpty
                          ? controller.settings.value.appLogo
                          : AppImages.defaultImage,
                    ),
                    Expanded(
                      child: Text(
                        controller.settings.value.appName,
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
                    ),
                    const AppMenuItem(
                      route: Routes.dashboard,
                      icon: Iconsax.status,
                      itemName: 'Dashboard',
                    ),
                    const AppMenuItem(route: Routes.media, icon: Iconsax.image, itemName: 'Media'),
                    const AppMenuItem(
                      route: Routes.categories,
                      icon: Iconsax.image,
                      itemName: 'Categories',
                    ),
                    const AppMenuItem(
                      route: Routes.brands,
                      icon: Iconsax.dcube,
                      itemName: 'Brands',
                    ),
                    const AppMenuItem(
                      route: Routes.banners,
                      icon: Iconsax.picture_frame,
                      itemName: 'Banners',
                    ),
                    const AppMenuItem(
                      route: Routes.products,
                      icon: Iconsax.shopping_bag,
                      itemName: 'Products',
                    ),
                    const AppMenuItem(
                      route: Routes.customers,
                      icon: Iconsax.profile_2user,
                      itemName: 'Customers',
                    ),
                    const AppMenuItem(route: Routes.orders, icon: Iconsax.box, itemName: 'Orders'),
                    // Other menu items
                    Text(
                      'OTHER',
                      style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
                    ),
                    const AppMenuItem(
                      route: Routes.profile,
                      icon: Iconsax.user,
                      itemName: 'Profile',
                    ),
                    const AppMenuItem(
                      route: Routes.settings,
                      icon: Iconsax.setting_2,
                      itemName: 'Settings',
                    ),
                    const AppMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
