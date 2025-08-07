import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/app_circular_icon.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = DashboardController.instance;
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppCircularIcon(
                icon: Iconsax.status,
                backgroundColor: Colors.amber.withValues(alpha: 0.1),
                color: Colors.amber,
                size: AppSizes.md,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Text('Order Status', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          // Pie Chart
          Obx(
            () => controller.orderStatusData.isNotEmpty
                ? SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (event, pieTouchResponse) {},
                          enabled: true,
                        ),
                        sections: controller.orderStatusData.entries.map((entry) {
                          final status = entry.key;
                          final count = entry.value;
                          return PieChartSectionData(
                            color: HelperFunctions.getOrderStatusColor(status),
                            value: count.toDouble(),
                            title: '$count',
                            radius: 70,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [AppLoaderAnimation()],
                    ),
                  ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          // Status and color meta
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => DataTable(
                columns: const [
                  DataColumn(
                    label: Text('Status', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  DataColumn(
                    label: Text('Orders', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  DataColumn(
                    label: Text('Total', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                ],
                rows: controller.orderStatusData.entries.map((entry) {
                  final status = entry.key;
                  final count = entry.value;
                  final totalAmount = controller.totalAmounts[status] ?? 0;
                  final String displayStatus = controller.getDisplayStatusName(status);
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            AppContainer(
                              width: 16,
                              height: 16,
                              radius: 8,
                              color: HelperFunctions.getOrderStatusColor(status),
                            ),
                            const SizedBox(width: AppSizes.xs),
                            Expanded(child: Text(displayStatus)),
                          ],
                        ),
                      ),
                      DataCell(Text(count.toString())),
                      DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
