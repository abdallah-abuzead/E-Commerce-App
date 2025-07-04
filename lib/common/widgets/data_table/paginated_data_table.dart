import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_sizes.dart';
import '../loaders/app_animation_loader_widget.dart';

class AppPaginatedDataTable extends StatelessWidget {
  const AppPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = AppSizes.xl * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  /// whether to sort the data in ascending or descending order
  final bool sortAscending;

  /// the index of the column to sort by
  final int? sortColumnIndex;

  /// the number of rows to display per page
  final int rowsPerPage;

  /// Data source for the DataTable
  final DataTableSource source;

  /// List Columns to display in the DataTable
  final List<DataColumn> columns;

  /// callback function to handle page changes
  final Function(int)? onPageChanged;

  ///Height of each data row in the table
  final double dataRowHeight;

  /// Height of the entire DataTable
  final double tableHeight;

  /// Minimum width of the entire DataTable
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tableHeight,
      child: Theme(
        data: Theme.of(
          context,
        ).copyWith(cardTheme: const CardThemeData(color: Colors.white, elevation: 0)),
        child: PaginatedDataTable2(
          /// Columns & Data Source
          columns: columns,
          source: source,

          /// Table properties & styles
          columnSpacing: 12,

          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          dataRowHeight: dataRowHeight,
          headingTextStyle: Theme.of(
            context,
          ).textTheme.titleMedium!.apply(color: AppColors.textSecondary),
          headingRowColor: WidgetStateProperty.resolveWith(
            (states) => AppColors.primaryBackgroundColor,
          ),
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.borderRadiusMd),
              topRight: Radius.circular(AppSizes.borderRadiusMd),
            ),
          ),
          empty: const AppAnimationLoaderWidget(
            animation: AppImages.packageAnimation,
            text: 'Nothing Found',
            height: 200,
            width: 200,
          ),

          /// Checkbox column for selecting rows
          showCheckboxColumn: true,

          /// Pagination
          showFirstLastButtons: true,
          onPageChanged: onPageChanged,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},
          rowsPerPage: rowsPerPage,

          /// Sorting
          sortAscending: sortAscending,
          sortArrowAlwaysVisible: true,
          sortArrowIcon: Icons.line_axis,
          sortColumnIndex: sortColumnIndex,
          sortArrowBuilder: (ascending, sorted) {
            if (sorted) {
              return Icon(
                ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                size: AppSizes.iconSm,
              );
            } else {
              return const Icon(Iconsax.arrow_3, size: AppSizes.iconSm);
            }
          },
        ),
      ),
    );
  }
}
