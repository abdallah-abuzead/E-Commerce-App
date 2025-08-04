import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/products/edit_product_controller.dart';
import '../../../../models/product_model.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final EditProductController controller = EditProductController.instance;

    return AppContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text
            Text('Basic Information', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Product title input field
            TextFormField(
              controller: controller.title,
              validator: (value) => Validator.validateEmptyText('Product Title', value),
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Product Description Input Field
            SizedBox(
              height: 300,
              child: TextFormField(
                controller: controller.description,
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) => Validator.validateEmptyText('Product Description', value),
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Add your Product Description here...',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
