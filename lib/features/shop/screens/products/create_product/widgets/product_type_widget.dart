import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/products/create_product_controller.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateProductController controller = CreateProductController.instance;

    return Obx(
      () => Row(
        children: [
          Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: AppSizes.spaceBtwItems),
          // Radio button for single product type
          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) => controller.productType.value = value ?? ProductType.single,
            child: const Text('Single', style: TextStyle(fontSize: 14)),
          ),
          // Radio button for single product type
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) => controller.productType.value = value ?? ProductType.single,
            child: const Text('Variable', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
