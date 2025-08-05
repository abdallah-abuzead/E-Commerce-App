import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout_template.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/responsive_design/order_details_desktop.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/responsive_design/order_details_mobile.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/responsive_design/order_details_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return SiteLayoutTemplate(
      desktop: OrderDetailsDesktop(order: order),
      tablet: OrderDetailsTablet(order: order),
      mobile: OrderDetailsMobile(order: order),
    );
  }
}
