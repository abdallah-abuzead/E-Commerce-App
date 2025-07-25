import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/data_table/app_table_action_buttons.dart';
import '../../../../controllers/categories/categories_controller.dart';

class CategoryRows extends DataTableSource {
  final CategoriesController controller = Get.find<CategoriesController>();

  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.allItems.firstWhereOrNull(
      (item) => item.id == category.parentId,
    );
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
                image: category.image,
                imageType: ImageType.network,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  category.name,
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
        DataCell(Text(parentCategory?.name ?? '')),
        DataCell(
          category.isFeatured
              ? const Icon(Iconsax.heart5, color: AppColors.primary)
              : const Icon(Iconsax.heart),
        ),
        DataCell(Text(category.createdAt == null ? '' : category.formatedCreatedDate)),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editCategory, arguments: category),
            onDeletePressed: () => controller.confirmAndDeleteItem(category),
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
  int get selectedRowCount => 0;
}
