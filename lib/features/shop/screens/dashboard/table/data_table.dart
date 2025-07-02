import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaginatedDataTable(
      minWidth: 700,
      tableHeight: 350,
      dataRowHeight: AppSizes.xl * 1.3,

      columns: const [
        DataColumn2(label: Text('Order ID')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Amount')),
      ],
      source: OrderRows(),
    );
  }
}
