import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_design/customers_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_design/customers_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_design/customers_tablet.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: CustomersDesktop(),
      tablet: CustomersTablet(),
      mobile: CustomersMobile(),
    );
  }
}
