import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/table/table_source.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/products/products_controller.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController controller = Get.put(ProductsController());
    Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
    Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));
    return AppPaginatedDataTable(
      minWidth: 1000,
      sortColumnIndex: controller.sortColumnIndex.value,
      sortAscending: controller.sortAscending.value,
      columns: [
        DataColumn2(
          label: const Text('Product'),
          fixedWidth: !DeviceUtils.isDesktopScreen(Get.context!) ? 300 : 400,
          onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
        ),
        DataColumn2(
          label: const Text('Stock'),
          onSort: (columnIndex, ascending) => controller.sortByStock(columnIndex, ascending),
        ),
        DataColumn2(
          label: const Text('Sold'),
          onSort: (columnIndex, ascending) => controller.sortBySoldItems(columnIndex, ascending),
        ),
        const DataColumn2(label: Text('Brand')),
        DataColumn2(
          label: const Text('Price'),
          onSort: (columnIndex, ascending) => controller.sortByPrice(columnIndex, ascending),
        ),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ProductRows(),
    );
  }
}
