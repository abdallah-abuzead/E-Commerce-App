import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utils.dart';
import '../../../../controllers/orders/orders_controller.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
    Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));
    return Obx(() {
      return AppPaginatedDataTable(
        minWidth: 700,
        sortColumnIndex: controller.sortColumnIndex.value,
        sortAscending: controller.sortAscending.value,
        columns: [
          DataColumn2(
            label: const Text('Order ID'),
            onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Date'),
            onSort: (columnIndex, ascending) => controller.sortByDate(columnIndex, ascending),
          ),
          const DataColumn2(label: Text('Items')),
          DataColumn2(
            label: const Text('Status'),
            fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? 120 : null,
          ),
          DataColumn2(
            label: const Text('Amount'),
            onSort: (columnIndex, ascending) =>
                controller.sortByTotalAmount(columnIndex, ascending),
          ),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: OrdersRows(),
      );
    });
  }
}
