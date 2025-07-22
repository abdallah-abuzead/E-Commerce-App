import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/app_table_action_buttons.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';

class OrdersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final OrderModel order = OrderModel(
      id: 'id',
      status: OrderStatus.pending,
      totalAmount: 365,
      orderDate: DateTime.now(),
      items: [],
    );
    return DataRow2(
      onTap: () => Get.toNamed(Routes.orderDetails, arguments: order),
      selected: false,
      onSelectChanged: (value) {},
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
            onViewPressed: () => Get.toNamed(Routes.orderDetails, arguments: order),
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
