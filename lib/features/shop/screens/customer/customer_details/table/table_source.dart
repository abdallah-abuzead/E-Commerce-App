import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';

class CustomerOrdersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final OrderModel order = OrderModel(
      id: 'id',
      status: OrderStatus.shipped,
      totalAmount: 235.5,
      orderDate: DateTime.now(),
      items: [],
      shippingCost: 0,
      taxCost: 0,
    );
    const String totalAmount = '2563.5';
    return DataRow2(
      selected: false,
      onTap: () => Get.toNamed(Routes.orderDetails, arguments: order),
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formatedOrderDate)),
        const DataCell(Text('${5} Items')),
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
        const DataCell(Text('\$$totalAmount')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
