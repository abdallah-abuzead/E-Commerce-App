import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_images.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Personal Information Card
          Row(
            children: [
              const AppRoundedImage(
                padding: 0,
                backgroundColor: AppColors.primaryBackground,
                image: AppImages.user,
                imageType: ImageType.asset,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Omar Alaa',
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
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Meta data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Username')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(child: Text('admin', style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(child: Text('Egypt', style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text('+20-112-336-2002', style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),

          // Divider
          const Divider(),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Additional details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Order', style: Theme.of(context).textTheme.titleLarge),
                    const Text('7 Days Ago, #[36d45]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Average Order Value', style: Theme.of(context).textTheme.titleLarge),
                    const Text('\$352'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registered', style: Theme.of(context).textTheme.titleLarge),
                    Text(customer.formatedCreatedDate),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Marketing', style: Theme.of(context).textTheme.titleLarge),
                    const Text('Subscribed'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
