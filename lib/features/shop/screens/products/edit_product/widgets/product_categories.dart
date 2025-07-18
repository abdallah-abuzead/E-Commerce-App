import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../models/category_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          MultiSelectDialogField(
            buttonText: const Text('Select Categories'),
            title: const Text('Categories'),
            items: [
              MultiSelectItem(CategoryModel(id: 'id', name: 'Shoes', image: 'image'), 'Shoes'),
              MultiSelectItem(CategoryModel(id: 'id', name: 'Shirts', image: 'image'), 'Shirts'),
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {},
          ),
        ],
      ),
    );
  }
}
