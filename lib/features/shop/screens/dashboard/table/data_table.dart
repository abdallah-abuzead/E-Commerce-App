import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/orders/orders_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrdersController.instance;
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return AppPaginatedDataTable(
        minWidth: 700,
        tableHeight: 350,
        dataRowHeight: AppSizes.xl * 1.3,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        emptyWidgetHeight: 150,
        columns: [
          DataColumn2(
            label: const Text('Order ID'),
            onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending),
          ),
          const DataColumn2(label: Text('Date')),
          const DataColumn2(label: Text('Items')),
          DataColumn2(
            label: const Text('Status'),
            fixedWidth: DeviceUtils.isMobileScreen(context) ? 120 : null,
          ),
          const DataColumn2(label: Text('Amount')),
        ],
        source: OrderRows(),
      );
    });
  }
}
