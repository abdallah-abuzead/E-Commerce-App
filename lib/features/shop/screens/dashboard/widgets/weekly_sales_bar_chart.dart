import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/app_container.dart';
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
          Text('Weekly Sales', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwSections),
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                titlesData: buildFlTitlesData(),
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
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
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
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: true, interval: 200, reservedSize: 50),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
