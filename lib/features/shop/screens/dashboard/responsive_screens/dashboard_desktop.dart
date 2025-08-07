import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/recent_orders.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales_bar_chart.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/order_status_pie_chart.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
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
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => DashboardCard(
                      headingIcon: Iconsax.note,
                      headingIconColor: Colors.blue,
                      headingIconBgColor: Colors.blue.withValues(alpha: 0.1),
                      context: context,
                      title: 'Sales total',
                      stats: 25,
                      subtitle:
                          '\$${controller.ordersController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: Obx(
                    () => DashboardCard(
                      headingIcon: Iconsax.external_drive,
                      headingIconColor: Colors.green,
                      headingIconBgColor: Colors.green.withValues(alpha: 0.1),
                      context: context,
                      title: 'Average order value',
                      stats: 15,
                      subtitle:
                          '\$${(controller.ordersController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.ordersController.allItems.length).toStringAsFixed(2)}',
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: Obx(
                    () => DashboardCard(
                      headingIcon: Iconsax.box,
                      headingIconColor: Colors.deepPurple,
                      headingIconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
                      context: context,
                      title: 'Total orders',
                      stats: 44,
                      subtitle: controller.ordersController.allItems.length.toString(),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: Obx(
                    () => DashboardCard(
                      headingIcon: Iconsax.user,
                      headingIconColor: Colors.deepOrange,
                      headingIconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
                      context: context,
                      title: 'Visitors',
                      stats: 2,
                      subtitle: controller.customersController.allItems.length.toString(),
                    ),
                  ),
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
