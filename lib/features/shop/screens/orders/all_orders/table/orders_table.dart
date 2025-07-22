import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utils.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaginatedDataTable(
      minWidth: 700,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(
          label: const Text('Status'),
          fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? 120 : null,
        ),
        const DataColumn2(label: Text('Amount')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: OrdersRows(),
    );
  }
}
