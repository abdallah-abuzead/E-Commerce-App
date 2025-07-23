import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/order_model.dart';

class OrderCustomerInfo extends StatelessWidget {
  const OrderCustomerInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        AppContainer(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSizes.spaceBtwSections),

              Row(
                children: [
                  const AppRoundedImage(
                    padding: 0,
                    backgroundColor: AppColors.primaryBackground,
                    imageType: ImageType.asset,
                    image: AppImages.user,
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ahmed Ali',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Text('support@me.com', overflow: TextOverflow.ellipsis, maxLines: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Contact Info
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Contact Person', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text('Ahmed Ali', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text('support@me.com', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text('+20 *** *** ****', style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Shipping Address
        SizedBox(
          width: double.infinity,
          child: AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Shipping Address', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Text('2B Nasr City', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Text(
                  '13B Suze-Al-Methak Str., Nasr City, Cairo, Egypt',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Contact Info: Adjust this address as per your needs
        SizedBox(
          width: double.infinity,
          child: AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Billing Address', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Text('2B Nasr City', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Text(
                  '13B Suze-Al-Methak Str., Nasr City, Cairo, Egypt',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
