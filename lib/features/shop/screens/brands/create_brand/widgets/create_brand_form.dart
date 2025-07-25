import 'package:ecommerce_admin_panel/features/shop/controllers/brands/create_brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/categories/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/chips/app_choice_chip.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/images/app_image_uploader.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/validators/validator.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return AppContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),
            Text('Create New Brand', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: controller.nameController,
              validator: (value) => Validator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Text('Select Categories', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spaceBtwInputFields / 2),
            Obx(
              () => Wrap(
                spacing: AppSizes.sm,
                children: CategoriesController.instance.allItems
                    .map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.sm),
                        child: AppChoiceChip(
                          text: category.name,
                          selected: controller.selectedCategories.contains(category),
                          onSelected: (value) => controller.toggleSelection(category),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            Obx(
              () => AppImageUploader(
                width: 80,
                height: 80,
                image: controller.imageUrl.value.isNotEmpty
                    ? controller.imageUrl.value
                    : AppImages.defaultImage,
                imageType: controller.imageUrl.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () async => await controller.pickImage(),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Obx(
              () => CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged: (value) => controller.isFeatured.value = value ?? false,
                child: const Text('Featured', style: TextStyle(fontSize: AppSizes.fontSizeSm)),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async => await controller.createBrand(),
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
