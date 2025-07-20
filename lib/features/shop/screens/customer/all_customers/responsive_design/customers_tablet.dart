import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/table/customers_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/data_table/app_table_header.dart';
import '../../../../../../utils/constants/app_sizes.dart';

class CustomersTablet extends StatelessWidget {
  const CustomersTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            BreadcrumbWithHeading(heading: 'Customers', breadcrumbItems: ['Customers']),
            SizedBox(height: AppSizes.spaceBtwSections),

            // Table Body
            AppContainer(
              child: Column(
                children: [
                  // Table Header
                  AppTableHeader(showLeftWidget: false),
                  SizedBox(height: AppSizes.spaceBtwItems),

                  // Table
                  CustomersTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
