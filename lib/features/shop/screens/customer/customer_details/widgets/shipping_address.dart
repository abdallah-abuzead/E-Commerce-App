import 'package:ecommerce_admin_panel/common/widgets/loaders/app_loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/customers/customer_details_controller.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailsController.instance;
    controller.getCustomerAddresses();
    return Obx(() {
      if (controller.addressesLoading.value) return const AppLoaderAnimation();
      AddressModel selectedAddress = AddressModel.empty();
      if (controller.customer.value.addresses != null &&
          controller.customer.value.addresses!.isNotEmpty) {
        selectedAddress = controller.customer.value.addresses!
            .where((address) => address.selectedAddress)
            .single;
      }
      return AppContainer(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Meta data
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Name')),
                const Text(':'),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(selectedAddress.name, style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Country')),
                const Text(':'),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.country,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Phone Number')),
                const Text(':'),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.formatedPhoneNumber,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Address')),
                const Text(':'),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
