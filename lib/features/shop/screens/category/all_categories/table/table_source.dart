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

class ProductRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const AppRoundedImage(
                width: 50,
                height: 50,
                padding: AppSizes.xs,
                image: AppImages.acerLogo,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  'Product Title',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const DataCell(Text('256')),
        DataCell(
          Row(
            children: [
              const AppRoundedImage(
                width: 35,
                height: 35,
                padding: AppSizes.xs,
                image: AppImages.acerLogo,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  'Nike',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const DataCell(Text('\$99.9')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editProduct, arguments: ProductModel()),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
