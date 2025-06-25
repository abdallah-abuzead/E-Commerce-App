import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/recent_orders.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales_bar_chart.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/order_status_pie_chart.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Cards
            const Row(
              children: [
                Expanded(
                  child: DashboardCard(title: 'Sales total', subtitle: '\$365.6', stats: 25),
                ),
                SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: DashboardCard(title: 'Average order value', subtitle: '\$25', stats: 15),
                ),
                SizedBox(width: AppSizes.spaceBtwItems),
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

            /// Graphs
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      /// Bar Graph
                      WeeklySalesBarChart(),
                      SizedBox(height: AppSizes.spaceBtwSections),

                      /// Orders
                      RecentOrders(),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.spaceBtwSections),

                /// Pie Chart
                Expanded(child: OrderStatusPieChart()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
