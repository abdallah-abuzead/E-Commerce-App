import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/app_table_action_buttons.dart';
import '../../../../controllers/customers/customers_controller.dart';

class CustomersRows extends DataTableSource {
  final controller = CustomersController.instance;

  @override
  DataRow? getRow(int index) {
    final UserModel customer = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      onTap: () => Get.toNamed(
        Routes.customerDetails,
        arguments: customer,
        parameters: {'customerId': customer.id ?? ''},
      ),
      cells: [
        DataCell(
          Row(
            children: [
              AppRoundedImage(
                width: 50,
                height: 50,
                padding: AppSizes.sm,
                image: customer.profilePicture,
                imageType: ImageType.network,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  customer.fullName,
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
        DataCell(Text(customer.email)),
        DataCell(Text(customer.fullName)),
        DataCell(Text(customer.createdAt != null ? customer.formatedCreatedDate : '')),
        DataCell(
          AppTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(
              Routes.customerDetails,
              arguments: customer,
              parameters: {'customerId': customer.id ?? ''},
            ),
            onDeletePressed: () => controller.confirmAndDeleteItem(customer),
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
