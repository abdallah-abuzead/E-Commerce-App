import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/app_sizes.dart';
import '../../../../utils/device/device_utils.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.grey)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      child: AppBar(
        leading: !DeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu),
              )
            : null,
        title: DeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Search anything...',
                    prefixIcon: Icon(Iconsax.search_normal),
                  ),
                ),
              )
            : null,
        actions: [
          if (!DeviceUtils.isDesktopScreen(context))
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.search_normal),
            ),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification)),
          const SizedBox(width: AppSizes.spaceBtwItems / 2),
          Row(
            children: [
              const AppRoundedImage(
                imageType: ImageType.asset,
                image: AppImages.user,
                width: 40,
                height: 40,
                padding: 2,
                borderRadius: 20,
              ),
              const SizedBox(width: AppSizes.sm),
              if (!DeviceUtils.isMobileScreen(context))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coding with Me',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'support@codingwithme.com',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight() + 15);
}
