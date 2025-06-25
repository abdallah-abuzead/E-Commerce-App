import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/app_container.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_pie_chart.dart';
import '../widgets/weekly_sales_bar_chart.dart';

class DashboardTablet extends StatelessWidget {
  const DashboardTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Header
            Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const Row(
              children: [
                Expanded(
                  child: DashboardCard(title: 'Sales total', subtitle: '\$365.6', stats: 25),
                ),
                SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: DashboardCard(title: 'Average order value', subtitle: '\$25', stats: 15),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const Row(
              children: [
                Expanded(
                  child: DashboardCard(title: 'Total orders', subtitle: '36', stats: 44),
                ),
                SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: DashboardCard(title: 'Visitors', subtitle: '25,35', stats: 2),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Bar Graph
            const WeeklySalesBarChart(),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Orders
            const AppContainer(),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Pie Chart
            const OrderStatusPieChart(),
          ],
        ),
      ),
    );
  }
}
