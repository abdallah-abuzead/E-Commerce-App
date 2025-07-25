import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/images/app_image_uploader.dart';
import '../../../../../../common/widgets/shimmers/app_shimmer_effect.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../controllers/categories/categories_controller.dart';
import '../../../../controllers/categories/edit_category_controller.dart';
import '../../../../models/category_model.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    final categoriesController = Get.put(CategoriesController());
    editController.init(category);
    return AppContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),
            Text('Update Category', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: editController.nameController,
              validator: (value) => Validator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Obx(
              () => categoriesController.isLoading.value
                  ? const AppShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField(
                      value: editController.selectedParent.value.id.isNotEmpty
                          ? editController.selectedParent.value
                          : null,
                      decoration: const InputDecoration(
                        hintText: 'Parent Category',
                        labelText: 'Parent Category',
                        prefixIcon: Icon(Iconsax.bezier),
                      ),
                      onChanged: (newValue) => editController.selectedParent.value = newValue!,
                      items: categoriesController.allItems.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [Text(category.name)],
                          ),
                        );
                      }).toList(),
                    ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
            Obx(
              () => AppImageUploader(
                width: 80,
                height: 80,
                image: editController.imageUrl.value.isNotEmpty
                    ? editController.imageUrl.value
                    : AppImages.defaultImage,
                imageType: editController.imageUrl.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => editController.pickImage(),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Obx(
              () => CheckboxMenuButton(
                value: editController.isFeatured.value,
                onChanged: (value) => editController.isFeatured.value = value ?? false,
                child: const Text('Featured', style: TextStyle(fontSize: AppSizes.fontSizeSm)),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => editController.updateCategory(category),
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
