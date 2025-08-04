import 'package:ecommerce_admin_panel/features/shop/controllers/categories/categories_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/helpers/app_cloud_helper_functions.dart';
import '../../../../models/category_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final editProductController = EditProductController.instance;
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          FutureBuilder(
            future: editProductController.loadSelectedCategories(product.id),
            builder: (context, snapshot) {
              final widget = AppCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (widget != null) return widget;

              return MultiSelectDialogField(
                buttonText: const Text('Select Categories'),
                title: const Text('Categories'),
                initialValue: List<CategoryModel>.from(editProductController.selectedCategories),
                items: CategoriesController.instance.allItems
                    .map((category) => MultiSelectItem(category, category.name))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) => editProductController.selectedCategories.assignAll(values),
              );
            },
          ),
        ],
      ),
    );
  }
}
