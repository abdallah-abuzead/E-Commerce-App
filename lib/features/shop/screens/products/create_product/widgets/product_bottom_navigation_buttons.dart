import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/create_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button
          OutlinedButton(
            onPressed: () => CreateProductController.instance.resetValues(),
            child: const Text('Discard'),
          ),
          const SizedBox(width: AppSizes.spaceBtwItems / 2),

          // Save changes button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => CreateProductController.instance.createProduct(),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
