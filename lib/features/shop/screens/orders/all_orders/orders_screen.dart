import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/responsive_design/orders_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/responsive_design/orders_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/responsive_design/orders_tablet.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: OrdersDesktop(),
      tablet: OrdersTablet(),
      mobile: OrdersMobile(),
    );
  }
}
