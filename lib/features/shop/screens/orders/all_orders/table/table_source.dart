import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/app_table_action_buttons.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';
import '../../../../controllers/orders/orders_controller.dart';

class OrdersRows extends DataTableSource {
  final controller = OrdersController.instance;

  @override
  DataRow? getRow(int index) {
    final OrderModel order = controller.filteredItems[index];
    return DataRow2(
      onTap: () =>
          Get.toNamed(Routes.orderDetails, arguments: order, parameters: {'orderId': order.docId}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formatedOrderDate)),
        DataCell(Text('${order.items.length} Items')),
        DataCell(
          Row(
            children: [
              AppContainer(
                height: AppSizes.xl,
                radius: AppSizes.cardRadiusSm,
                padding: const EdgeInsets.symmetric(vertical: AppSizes.xs, horizontal: AppSizes.md),
                color: HelperFunctions.getOrderStatusColor(order.status).withValues(alpha: 0.1),
                child: Text(
                  order.status.name.capitalize.toString(),
                  style: TextStyle(color: HelperFunctions.getOrderStatusColor(order.status)),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text('\$${order.totalAmount}')),
        DataCell(
          AppTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(
              Routes.orderDetails,
              arguments: order,
              parameters: {'orderId': order.docId},
            ),
            onDeletePressed: () => controller.confirmAndDeleteItem(order),
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
