import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/order_customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transactions.dart';

class OrderDetailsDesktop extends StatelessWidget {
  const OrderDetailsDesktop({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            BreadcrumbWithHeading(
              returnToPreviousScreen: true,
              heading: order.id,
              breadcrumbItems: const [Routes.orders, 'Details'],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side Order Information
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Order Info
                      OrderInfo(order: order),
                      const SizedBox(height: AppSizes.spaceBtwSections),

                      // Order Items
                      OrderItems(order: order),
                      const SizedBox(height: AppSizes.spaceBtwSections),

                      // Transactions
                      OrderTransactions(order: order),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwSections),

                // Right Side Order Information
                Expanded(child: OrderCustomerInfo(order: order)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
