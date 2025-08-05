import 'package:ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customers/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/widgets/customer_info.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/widgets/customer_orders.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/widgets/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/app_sizes.dart';

class CustomerDetailsDesktop extends StatelessWidget {
  const CustomerDetailsDesktop({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailsController());
    controller.customer.value = customer;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            BreadcrumbWithHeading(
              returnToPreviousScreen: true,
              heading: customer.fullName,
              breadcrumbItems: const [Routes.customers, 'Details'],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side customer information
                Expanded(
                  child: Column(
                    children: [
                      // Customer Info
                      CustomerInfo(customer: customer),
                      const SizedBox(height: AppSizes.spaceBtwSections),

                      // Shipping Address
                      const ShippingAddress(),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwSections),

                // Right side customer orders
                const Expanded(flex: 2, child: CustomerOrders()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
