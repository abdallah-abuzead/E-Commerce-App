import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/shimmers/app_shimmer_effect.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brands/brands_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/create_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
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
                        controller: controller.brandTextField = ctr,
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
