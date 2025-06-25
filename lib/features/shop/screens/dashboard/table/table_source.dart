import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/order_model.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final OrderModel order = DashboardController.orders[index];
    return DataRow2(
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formatedOrderDate)),
        const DataCell(Text('5 Items')),
        DataCell(
          AppContainer(
            height: AppSizes.xl,
            radius: AppSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.xs),
            color: HelperFunctions.getOrderStatusColor(order.status).withValues(alpha: 0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: Theme.of(Get.context!).textTheme.bodyMedium!.apply(
                color: HelperFunctions.getOrderStatusColor(order.status),
              ),
            ),
          ),
        ),

        DataCell(Text('\$${order.totalAmount}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
