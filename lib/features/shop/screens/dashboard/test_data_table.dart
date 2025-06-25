import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../utils/constants/app_sizes.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final TestDashboardController controller = Get.put(TestDashboardController());

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (query) => controller.searchQuery(query),
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Iconsax.search_normal),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Expanded(
              child: Obx(() {
                Visibility(
                  visible: false,
                  child: Text(controller.filteredDataList.length.toString()),
                );
                return AppPaginatedDataTable(
                  sortAscending: controller.sortAscending.value,
                  sortColumnIndex: controller.sortColumnIndex.value,
                  columns: [
                    const DataColumn2(label: Text('Column 1')),
                    DataColumn(
                      label: const Text('Column 2'),
                      onSort: (columnIndex, ascending) =>
                          controller.sortById(columnIndex, ascending),
                    ),
                    const DataColumn(label: Text('Column 3')),
                    DataColumn(
                      label: const Text('Column 4'),
                      onSort: (columnIndex, ascending) =>
                          controller.sortById(columnIndex, ascending),
                    ),
                  ],
                  source: MyData(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final TestDashboardController controller = Get.put(TestDashboardController());

  @override
  DataRow? getRow(int i) {
    final Map<String, dynamic> data = controller.filteredDataList[i];
    return DataRow2(
      onTap: () => controller.selectedRows[i] = !controller.selectedRows[i],
      selected: controller.selectedRows[i],
      onSelectChanged: (value) => controller.selectedRows[i] = value ?? false,
      cells: [
        DataCell(Text(data['column1'])),
        DataCell(Text(data['column2'])),
        DataCell(Text(data['column3'])),
        DataCell(Text(data['column4'])),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredDataList.length;

  @override
  int get selectedRowCount => 0;
}

class TestDashboardController extends GetxController {
  final RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredDataList = <Map<String, dynamic>>[].obs;
  final RxList<bool> selectedRows = <bool>[].obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void sortById(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    dataList.sort((a, b) {
      final valueA = a['column${columnIndex + 1}'].toString().toLowerCase();
      final valueB = b['column${columnIndex + 1}'].toString().toLowerCase();
      return ascending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
    });
  }

  void searchQuery(String query) {
    if (query.isEmpty) {
      filteredDataList.value = dataList;
    } else {
      filteredDataList.value = dataList
          .where(
            (item) => item.values.any(
              (value) => value.toString().toLowerCase().contains(query.toLowerCase()),
            ),
          )
          .toList();
    }
    selectedRows.value = List.filled(filteredDataList.length, false);
  }

  void fetchDummyData() {
    selectedRows.addAll(List.filled(36, false));
    dataList.addAll(
      List.generate(
        36,
        (i) => {
          'column1': 'Row ${i + 1}, Cell 1',
          'column2': 'Row ${i + 1}, Cell 2',
          'column3': 'Row ${i + 1}, Cell 3',
          'column4': 'Row ${i + 1}, Cell 4',
        },
      ),
    );
    filteredDataList.value = dataList;
  }
}
