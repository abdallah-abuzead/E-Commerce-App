import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/table/table_source.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: [
        DataColumn2(
          label: const Text('Brand'),
          fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? null : 200,
        ),
        const DataColumn2(label: Text('Categories')),
        DataColumn2(
          label: const Text('Featured'),
          fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? null : 100,
        ),
        DataColumn2(
          label: const Text('Date'),
          fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? null : 200,
        ),
        DataColumn2(
          label: const Text('Action'),
          fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? null : 100,
        ),
      ],
      source: BannersRows(),
    );
  }
}
