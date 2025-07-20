import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Address', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Meta data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Name')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(child: Text('Omar Alaa', style: Theme.of(context).textTheme.titleMedium)),
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
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Address')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  '13B Suez Street, Cairo, Egypt',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
