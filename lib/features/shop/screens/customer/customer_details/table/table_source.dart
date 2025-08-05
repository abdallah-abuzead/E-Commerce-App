import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';
import '../../../../controllers/customers/customer_details_controller.dart';

class CustomerOrdersRows extends DataTableSource {
  final controller = CustomerDetailsController.instance;

  @override
  DataRow? getRow(int index) {
    final OrderModel order = controller.filteredCustomerOrders[index];
    final totalAmount = order.items.fold(
      0.0,
      (previousValue, element) => previousValue + element.price,
    );
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      onTap: () =>
          Get.toNamed(Routes.orderDetails, arguments: order, parameters: {'orderId': order.docId}),
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
          AppContainer(
            height: AppSizes.xl,
            radius: AppSizes.sm,
            padding: const EdgeInsets.symmetric(vertical: AppSizes.xs, horizontal: AppSizes.md),
            color: HelperFunctions.getOrderStatusColor(order.status).withValues(alpha: 0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(color: HelperFunctions.getOrderStatusColor(order.status)),
            ),
          ),
        ),
        DataCell(Text('\$$totalAmount')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
