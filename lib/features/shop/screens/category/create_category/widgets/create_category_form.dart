import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/shimmers/app_shimmer_effect.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/categories/create_category_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/images/app_image_uploader.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../controllers/categories/categories_controller.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoriesController = Get.put(CategoriesController());
    return AppContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),
            Text('Create New Category', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: createController.nameController,
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
                      decoration: const InputDecoration(
                        hintText: 'Parent Category',
                        labelText: 'Parent Category',
                        prefixIcon: Icon(Iconsax.bezier),
                      ),
                      onChanged: (newValue) => createController.selectedParent.value = newValue!,
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
                image: createController.imageUrl.value.isNotEmpty
                    ? createController.imageUrl.value
                    : AppImages.defaultImage,
                imageType: createController.imageUrl.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => createController.pickImage(),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Obx(
              () => CheckboxMenuButton(
                value: createController.isFeatured.value,
                onChanged: (value) => createController.isFeatured.value = value ?? false,
                child: const Text('Featured', style: TextStyle(fontSize: AppSizes.fontSizeSm)),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => createController.createCategory(),
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
