import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/responsive_design/customer_details_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/responsive_design/customer_details_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/responsive_design/customer_details_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    return SiteLayoutTemplate(
      desktop: CustomerDetailsDesktop(customer: customer),
      tablet: CustomerDetailsTablet(customer: customer),
      mobile: CustomerDetailsMobile(customer: customer),
    );
  }
}
