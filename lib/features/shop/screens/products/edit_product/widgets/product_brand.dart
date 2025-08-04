import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/shimmers/app_shimmer_effect.dart';
import '../../../../controllers/brands/brands_controller.dart';
import '../../../../controllers/products/edit_product_controller.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final brandsController = Get.put(BrandsController());
    if (brandsController.allItems.isEmpty) {
      brandsController.fetchItems();
    }
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // TypeAheadField for brand selection
          Obx(
            () => brandsController.isLoading.value
                ? const AppShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
                    builder: (context, ctr, focusedNode) {
                      return TextFormField(
                        controller: controller.brandTextField,
                        focusNode: focusedNode,
                        decoration: const InputDecoration(
                          labelText: 'Select Brand',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Iconsax.box),
                        ),
                      );
                    },

                    suggestionsCallback: (pattern) {
                      return brandsController.allItems
                          .where(
                            (brand) => brand.name.toLowerCase().contains(pattern.toLowerCase()),
                          )
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(title: Text(suggestion.name));
                    },
                    onSelected: (suggestion) {
                      controller.selectedBrand.value = suggestion;
                      controller.brandTextField.text = suggestion.name;
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
