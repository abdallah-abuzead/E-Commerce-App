import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/products/edit_product_controller.dart';
import '../../../../controllers/products/product_attributes_controller.dart';
import '../../../../controllers/products/product_variations_controller.dart';
import '../../../../models/product_attribute_model.dart';
import '../../../../models/product_model.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final EditProductController productController = EditProductController.instance;
    final ProductAttributesController attributesController = Get.put(ProductAttributesController());
    final ProductVariationsController variationsController = Get.put(ProductVariationsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => productController.productType.value == ProductType.single
              ? const Column(
                  children: [
                    Divider(color: AppColors.primaryBackground),
                    SizedBox(height: AppSizes.spaceBtwSections),
                  ],
                )
              : const SizedBox.shrink(),
        ),

        Text('Add Product Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // Form to add new attribute
        Form(
          key: attributesController.attributesFormKey,
          child: DeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAttributeName(attributesController)),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Expanded(flex: 2, child: _buildAttributeTextField(attributesController)),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    _buildAddAttributeButton(attributesController),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(attributesController),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    _buildAttributeTextField(attributesController),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    _buildAddAttributeButton(attributesController),
                  ],
                ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // List of added attributes
        Text('Added Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // Display added attributes in a rounded container
        AppContainer(
          color: AppColors.primaryBackground,
          child: Obx(
            () => attributesController.productAttributes.isNotEmpty
                ? _buildAttributesList(context, attributesController)
                : _buildEmptyAttributes(),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Generate Variations Button
        Obx(
          () =>
              productController.productType.value == ProductType.variable &&
                  variationsController.productVariations.isEmpty
              ? Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () => variationsController.generateVariationsConfirmation(context),
                      icon: const Icon(Iconsax.activity),
                      label: const Text('Generate Variations'),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) => Validator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Material',
      ),
    );
  }

  Widget _buildAttributeTextField(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller.attributes,
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) => Validator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText: 'Add attributes separated by | Example: Green | Blue | Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        label: const Text('Add'),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: AppColors.secondary,
          side: const BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }

  Widget _buildAttributesList(BuildContext context, ProductAttributesController controller) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.productAttributes.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, i) {
        final ProductAttributeModel attribute = controller.productAttributes[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: Text(attribute.name ?? ''),
            subtitle: Text(attribute.values!.map((e) => e.trim()).toString()),
            trailing: IconButton(
              onPressed: () => controller.removeAttribute(i, context),
              icon: const Icon(Iconsax.trash, color: AppColors.error),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: AppImages.defaultImage,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        Text('There are no attributes added for this product'),
      ],
    );
  }
}
