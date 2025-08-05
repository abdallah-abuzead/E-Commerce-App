import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../models/order_model.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subtotal = order.items.fold(
      0.0,
      (previousValue, element) => previousValue + element.price * element.quantity,
    );
    return AppContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Items
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSizes.spaceBtwItems),
            itemBuilder: (_, i) {
              final item = order.items[i];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        AppRoundedImage(
                          backgroundColor: AppColors.primaryBackground,
                          imageType: item.image != null ? ImageType.network : ImageType.asset,
                          image: item.image ?? AppImages.defaultImage,
                        ),
                        const SizedBox(width: AppSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (item.selectedVariation != null)
                                Text(
                                  item.selectedVariation!.entries
                                      .map((e) => '${e.key}: ${e.value}')
                                      .toString(),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  SizedBox(
                    width: AppSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: DeviceUtils.isMobileScreen(context)
                        ? AppSizes.xl * 1.4
                        : AppSizes.xl * 2,
                    child: Text(
                      item.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: DeviceUtils.isMobileScreen(context)
                        ? AppSizes.xl * 1.4
                        : AppSizes.xl * 2,
                    child: Text(
                      '\$${item.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Items Total
          AppContainer(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            color: AppColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: Theme.of(context).textTheme.titleLarge),
                    Text('\$$subtotal', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount', style: Theme.of(context).textTheme.titleLarge),
                    Text('\$0.00', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${order.shippingCost.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${order.taxCost.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${order.totalAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
