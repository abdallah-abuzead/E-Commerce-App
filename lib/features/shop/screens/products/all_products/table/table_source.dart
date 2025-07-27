import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/app_table_action_buttons.dart';
import '../../../../controllers/products/products_controller.dart';

class ProductRows extends DataTableSource {
  final ProductsController controller = ProductsController.instance;

  @override
  DataRow? getRow(int index) {
    final ProductModel product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      onTap: () => Get.toNamed(Routes.editProduct, arguments: product),
      cells: [
        DataCell(
          Row(
            children: [
              AppRoundedImage(
                width: 50,
                height: 50,
                padding: AppSizes.xs,
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.title,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(controller.getProductStockTotal(product))),
        DataCell(Text(controller.getProductSoldQuantity(product))),
        DataCell(
          Row(
            children: [
              AppRoundedImage(
                width: 35,
                height: 35,
                padding: AppSizes.xs,
                image: product.brand?.image != null ? product.brand!.image : AppImages.defaultImage,
                imageType: product.brand?.image != null ? ImageType.network : ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.brand?.name ?? '',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text('\$${controller.getProductPrice(product)}')),
        DataCell(Text(product.formatedDate)),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editProduct, arguments: ProductModel.empty()),
            onDeletePressed: () => controller.confirmAndDeleteItem(product),
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
