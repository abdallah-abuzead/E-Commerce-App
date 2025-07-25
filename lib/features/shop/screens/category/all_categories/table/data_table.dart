import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/category/all_categories/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/categories/categories_controller.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return AppPaginatedDataTable(
        minWidth: 700,
        sortColumnIndex: controller.sortColumnIndex.value,
        sortAscending: controller.sortAscending.value,
        columns: [
          DataColumn2(
            label: const Text('Category'),
            onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Parent Category'),
            onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
          ),
          const DataColumn2(label: Text('Featured')),
          const DataColumn2(label: Text('Date')),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoryRows(),
      );
    });
  }
}
