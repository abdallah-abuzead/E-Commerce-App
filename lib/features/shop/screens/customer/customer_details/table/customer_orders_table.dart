import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utils.dart';

class CustomerOrdersTable extends StatelessWidget {
  const CustomerOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaginatedDataTable(
      minWidth: 550,
      tableHeight: 520,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(
          label: const Text('Status'),
          fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? 100 : null,
        ),
        const DataColumn2(label: Text('Amount'), numeric: true),
      ],
      source: CustomerOrdersRows(),
    );
  }
}
