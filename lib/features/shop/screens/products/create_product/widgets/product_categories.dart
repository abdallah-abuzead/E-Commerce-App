import 'package:ecommerce_admin_panel/common/widgets/shimmers/app_shimmer_effect.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/categories/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../controllers/products/create_product_controller.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(CategoriesController());
    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          Obx(
            () => categoriesController.isLoading.value
                ? const AppShimmerEffect(width: double.infinity, height: 50)
                : MultiSelectDialogField(
                    buttonText: const Text('Select Categories'),
                    title: const Text('Categories'),
                    items: categoriesController.allItems
                        .map((category) => MultiSelectItem(category, category.name))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      CreateProductController.instance.selectedCategories.assignAll(values);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
