import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/data_table/app_table_action_buttons.dart';
import '../../../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../controllers/banners/banners_controller.dart';

class BannersRows extends DataTableSource {
  final controller = BannersController.instance;

  @override
  DataRow? getRow(int index) {
    final BannerModel banner = controller.allItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      onTap: () => Get.toNamed(Routes.editBanner, arguments: banner),
      cells: [
        DataCell(
          AppRoundedImage(
            width: 180,
            height: 180,
            padding: AppSizes.sm,
            image: banner.imageUrl,
            imageType: ImageType.network,
            borderRadius: AppSizes.borderRadiusMd,
            backgroundColor: AppColors.primaryBackground,
            margin: 3,
          ),
        ),
        DataCell(Text(controller.formatRoute(banner.targetScreen))),
        DataCell(
          banner.active
              ? const Icon(Iconsax.eye, color: AppColors.primary)
              : const Icon(Iconsax.eye_slash),
        ),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editBanner, arguments: banner),
            onDeletePressed: () => controller.confirmAndDeleteItem(banner),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.allItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
