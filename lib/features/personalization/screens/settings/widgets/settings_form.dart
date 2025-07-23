import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/app_sizes.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppContainer(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.lg),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // App Name
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),

                // Tax and Shipping cost
                Row(
                  children: [
                    // Tax
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Tax %',
                          label: Text('Tax Rate (%)'),
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBtwInputFields),
                    // Shipping Cost
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Shipping Cost',
                          label: Text('Shipping Cost (\$)'),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBtwInputFields),
                    // Free Shipping Threshold
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Free Shipping After (\$)',
                          label: Text('Free Shipping Threshold (\$)'),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Update App Settings')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
