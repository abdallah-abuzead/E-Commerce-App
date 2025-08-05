import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/orders/orders_controller.dart';
import '../../../../models/order_model.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    controller.orderStatus.value = order.status;
    return AppContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Information', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(order.formatedOrderDate, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text('${order.items.length}', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                flex: DeviceUtils.isMobileScreen(context) ? 2 : 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    Obx(
                      () => Row(
                        children: [
                          AppContainer(
                            radius: AppSizes.cardRadiusSm,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.sm,
                              vertical: 0,
                            ),
                            color: HelperFunctions.getOrderStatusColor(
                              controller.orderStatus.value,
                            ).withValues(alpha: 0.1),
                            child: DropdownButton<OrderStatus>(
                              padding: EdgeInsets.zero,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.orderStatus.value = value;
                                }
                              },

                              value: controller.orderStatus.value,
                              items: OrderStatus.values.map((status) {
                                return DropdownMenuItem<OrderStatus>(
                                  value: status,
                                  child: Text(
                                    status.name.capitalize.toString(),
                                    style: TextStyle(
                                      color: HelperFunctions.getOrderStatusColor(status),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text('\$${order.totalAmount}', style: Theme.of(context).textTheme.bodyLarge),
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
