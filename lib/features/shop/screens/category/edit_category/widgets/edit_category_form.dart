import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/images/app_image_uploader.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../models/category_model.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),
            Text('Update Category', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              validator: (value) => Validator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            DropdownButtonFormField(
              decoration: const InputDecoration(
                hintText: 'Parent Category',
                labelText: 'Parent Category',
                prefixIcon: Icon(Iconsax.bezier),
              ),
              onChanged: (newValue) {},
              items: const [
                DropdownMenuItem(
                  value: '',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text('item.name')],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
            AppImageUploader(
              width: 80,
              height: 80,
              image: AppImages.defaultImage,
              imageType: ImageType.asset,
              onIconButtonPressed: () {},
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Featured', style: TextStyle(fontSize: AppSizes.fontSizeSm)),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text('Update')),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
