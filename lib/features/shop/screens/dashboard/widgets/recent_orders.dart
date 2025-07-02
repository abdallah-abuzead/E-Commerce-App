import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/app_container.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../table/data_table.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwSections),
          const DashboardOrderTable(),
        ],
      ),
    );
  }
}
