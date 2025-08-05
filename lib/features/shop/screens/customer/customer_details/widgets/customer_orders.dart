import 'package:ecommerce_admin_panel/common/widgets/loaders/app_animation_loader_widget.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/customers/customer_details_controller.dart';
import '../table/customer_orders_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailsController.instance;
    controller.getCustomerOrders();
    return AppContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Obx(() {
        if (controller.ordersLoading.value) return const AppLoaderAnimation();
        if (controller.allCustomerOrders.isEmpty) {
          return const AppAnimationLoaderWidget(
            text: 'No Orders Found',
            animation: AppImages.productIllustration,
          );
        }
        final totalAmount = controller.allCustomerOrders.fold(
          0.0,
          (previousValue, element) => previousValue + element.totalAmount,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Orders', style: Theme.of(context).textTheme.headlineMedium),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Total Spent '),
                      TextSpan(
                        text: '\$${totalAmount.toString()}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                      ),
                      TextSpan(
                        text: ' on ${controller.allCustomerOrders.length} Orders',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (query) => controller.searchQuery(query),
              decoration: const InputDecoration(
                hintText: 'Search Orders',
                prefixIcon: Icon(Iconsax.search_normal),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const CustomerOrdersTable(),
          ],
        );
      }),
    );
  }
}
