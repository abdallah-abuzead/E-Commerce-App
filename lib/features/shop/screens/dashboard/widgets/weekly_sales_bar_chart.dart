import 'package:ecommerce_admin_panel/common/widgets/icons/app_circular_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/app_container.dart';
import '../../../../../common/widgets/loaders/app_loader_animation.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class WeeklySalesBarChart extends StatelessWidget {
  const WeeklySalesBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withValues(alpha: 0.1),
                color: Colors.brown,
                size: AppSizes.md,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Text('Weekly Sales', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Obx(
            () => controller.weeklySales.isNotEmpty
                ? SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        titlesData: buildFlTitlesData(controller.weeklySales),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(top: BorderSide.none, right: BorderSide.none),
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: true,
                          horizontalInterval: 200,
                        ),
                        barGroups: controller.weeklySales
                            .asMap()
                            .entries
                            .map(
                              (entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                    width: 20,
                                    toY: entry.value,
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(AppSizes.sm),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                        groupsSpace: AppSizes.spaceBtwItems,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => AppColors.secondary,
                          ),
                          touchCallback: DeviceUtils.isDesktopScreen(context)
                              ? (barTouchEvent, barTouchResponse) {}
                              : null,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [AppLoaderAnimation(height: 200)],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData(List<double> weeklySales) {
    // Calculate the step height for thr left pricing
    final double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b).toDouble();
    final double stepHeight = (maxOrder / 10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final int index = value.toInt() % days.length;
            final day = days[index];
            return SideTitleWidget(
              space: 0,
              meta: meta,
              child: Text(day, style: const TextStyle(fontSize: 11)),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: stepHeight <= 0 ? 500 : stepHeight,
          reservedSize: 50,
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
