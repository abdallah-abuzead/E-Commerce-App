import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_sizes.dart';
import '../widgets/dashboard_card.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Header
            Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const DashboardCard(title: 'Sales total', subtitle: '\$365.6', stats: 25),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const DashboardCard(title: 'Average order value', subtitle: '\$25', stats: 15),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const DashboardCard(title: 'Total orders', subtitle: '36', stats: 44),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const DashboardCard(title: 'Visitors', subtitle: '25,35', stats: 2),
          ],
        ),
      ),
    );
  }
}
