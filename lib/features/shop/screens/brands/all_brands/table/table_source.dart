import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
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
import '../../../../models/brand_model.dart';

class BrandsRows extends DataTableSource {
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
                padding: AppSizes.sm,
                image: AppImages.acerLogo,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  'Name',
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: DeviceUtils.isMobileScreen(Get.context!) ? 0 : AppSizes.xs,
                    ),
                    child: const Chip(label: Text('Shoes'), padding: EdgeInsets.all(AppSizes.xs)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: DeviceUtils.isMobileScreen(Get.context!) ? 0 : AppSizes.xs,
                    ),
                    child: const Chip(
                      label: Text('TrackSuits'),
                      padding: EdgeInsets.all(AppSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: DeviceUtils.isMobileScreen(Get.context!) ? 0 : AppSizes.xs,
                    ),
                    child: const Chip(label: Text('Joggers'), padding: EdgeInsets.all(AppSizes.xs)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const DataCell(Icon(Iconsax.heart5, color: AppColors.primary)),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          AppTableActionButtons(
            onEditPressed: () => Get.toNamed(
              Routes.editBrand,
              arguments: BrandModel(id: '', name: '', image: ''),
            ),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
