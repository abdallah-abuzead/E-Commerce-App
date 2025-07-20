import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../table/customer_orders_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
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
                      text: '\$500.35',
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.primary),
                    ),
                    TextSpan(text: ' on ${5} Orders', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          TextFormField(
            onChanged: (query) {},
            decoration: const InputDecoration(
              hintText: 'Search Orders',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const CustomerOrdersTable(),
        ],
      ),
    );
  }
}
