import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../sidebar_controller.dart';

class AppMenuItem extends StatelessWidget {
  const AppMenuItem({super.key, required this.route, required this.icon, required this.itemName});

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final SidebarController menuController = Get.put(SidebarController());

    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (isHovering) => menuController.changeHoverItem(isHovering ? route : ''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(AppSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color: menuController.isActive(route) || menuController.isHovering(route)
                  ? AppColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSizes.lg,
                    right: AppSizes.md,
                    top: AppSizes.md,
                    bottom: AppSizes.md,
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: menuController.isActive(route) || menuController.isHovering(route)
                        ? AppColors.white
                        : AppColors.darkGrey,
                  ),
                ),
                Text(
                  itemName,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: menuController.isActive(route) || menuController.isHovering(route)
                        ? AppColors.white
                        : AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
