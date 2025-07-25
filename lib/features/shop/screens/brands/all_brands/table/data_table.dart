import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/table/table_source.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/brands/brands_controller.dart';

class BrandsTable extends StatelessWidget {
  const BrandsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandsController controller = Get.put(BrandsController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      final bool lgTable = controller.filteredItems.any(
        (element) => element.brandCategories != null && element.brandCategories!.length > 2,
      );
      return AppPaginatedDataTable(
        minWidth: 700,
        dataRowHeight: lgTable ? 96 : 64,
        tableHeight: lgTable ? 96 * 11.5 : 760,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
            label: const Text('Brand'),
            fixedWidth: DeviceUtils.isMobileScreen(Get.context!) ? null : 200,
            onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
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
        source: BrandsRows(),
      );
    });
  }
}
