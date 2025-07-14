import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/data_table/app_table_action_buttons.dart';
import '../../../../../../common/widgets/images/app_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';

class BannersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        const DataCell(
          AppRoundedImage(
            width: 180,
            height: 180,
            padding: AppSizes.sm,
            image: AppImages.acerLogo,
            imageType: ImageType.asset,
            borderRadius: AppSizes.borderRadiusMd,
            backgroundColor: AppColors.primaryBackground,
            margin: 3,
          ),
        ),
        const DataCell(Text('Shop')),
        const DataCell(Icon(Iconsax.eye, color: AppColors.primary)),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editBanner, arguments: BannerModel()),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
