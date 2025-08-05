import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/orders/order_details_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/order_model.dart';

class OrderCustomerInfo extends StatelessWidget {
  const OrderCustomerInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        AppContainer(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSizes.spaceBtwSections),

              Obx(
                () => Row(
                  children: [
                    AppRoundedImage(
                      padding: 0,
                      backgroundColor: AppColors.primaryBackground,
                      imageType: controller.customer.value.profilePicture.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                      image: controller.customer.value.profilePicture.isNotEmpty
                          ? controller.customer.value.profilePicture
                          : AppImages.user,
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            controller.customer.value.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Contact Info
        Obx(
          () => AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Contact Person', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Text(
                  controller.customer.value.fullName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Text(
                  controller.customer.value.email,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Text(
                  controller.customer.value.phoneNumber.isNotEmpty
                      ? controller.customer.value.formatedPhoneNo
                      : '+20 *** *** ****',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Shipping Address
        SizedBox(
          width: double.infinity,
          child: AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Shipping Address', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Text(
                  order.shippingAddress?.name ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Text(
                  order.shippingAddress?.toString() ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Contact Info: Adjust this address as per your needs
        SizedBox(
          width: double.infinity,
          child: AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Billing Address', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Text(
                  order.billingAddressSameAsShipping
                      ? order.shippingAddress?.name ?? ''
                      : order.billingAddress?.name ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Text(
                  order.billingAddressSameAsShipping
                      ? order.shippingAddress?.toString() ?? ''
                      : order.billingAddress?.toString() ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
