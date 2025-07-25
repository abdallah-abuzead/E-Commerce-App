import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/data_table/app_table_action_buttons.dart';
import '../../../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../controllers/brands/brands_controller.dart';
import '../../../../models/brand_model.dart';

class BrandsRows extends DataTableSource {
  final BrandsController controller = BrandsController.instance;

  @override
  DataRow? getRow(int index) {
    final BrandModel brand = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              AppRoundedImage(
                width: 50,
                height: 50,
                padding: AppSizes.sm,
                image: brand.image,
                imageType: ImageType.network,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  brand.name,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: AppSizes.xs,
                direction: DeviceUtils.isMobileScreen(Get.context!)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: brand.brandCategories == null
                    ? [const SizedBox.shrink()]
                    : brand.brandCategories!
                          .map(
                            (category) => Padding(
                              padding: EdgeInsets.only(
                                bottom: DeviceUtils.isMobileScreen(Get.context!) ? 0 : AppSizes.xs,
                              ),
                              child: Chip(
                                label: Text(category.name),
                                padding: const EdgeInsets.all(AppSizes.xs),
                              ),
                            ),
                          )
                          .toList(),
              ),
            ),
          ),
        ),
        DataCell(
          brand.isFeatured
              ? const Icon(Iconsax.heart5, color: AppColors.primary)
              : const Icon(Iconsax.heart),
        ),
        DataCell(Text(brand.createdAt != null ? brand.formatedCreatedDate : '')),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editBrand, arguments: brand),
            onDeletePressed: () => controller.confirmAndDeleteItem(brand),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
