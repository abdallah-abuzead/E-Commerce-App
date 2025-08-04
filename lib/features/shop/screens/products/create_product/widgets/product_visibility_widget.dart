import 'package:ecommerce_admin_panel/features/shop/controllers/products/create_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Label
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Radio buttons for product visibility
          Column(
            children: [
              _buildVisibilityRadioButton(ProductVisibility.published, 'Published'),
              _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(ProductVisibility value, String label) {
    final controller = CreateProductController.instance;

    return Obx(
      () => RadioMenuButton<ProductVisibility>(
        value: value,
        groupValue: controller.productVisibility.value,
        onChanged: (selection) => controller.productVisibility.value = selection!,
        child: Text(label, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
