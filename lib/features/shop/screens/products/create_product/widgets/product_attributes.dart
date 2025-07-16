import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.primaryBackground),
        const SizedBox(height: AppSizes.spaceBtwSections),

        Text('Add Product Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // Form to add new attribute
        Form(
          child: DeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAttributeName()),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Expanded(flex: 2, child: _buildAttributeTextField()),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    _buildAddAttributeButton(),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    _buildAttributeTextField(),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    _buildAddAttributeButton(),
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
          child: Column(children: [_buildAttributesList(context), _buildEmptyAttributes()]),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Generate Variations Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Iconsax.activity),
              label: const Text('Generate Variations'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttributeName() {
    return TextFormField(
      validator: (value) => Validator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Material',
      ),
    );
  }

  Widget _buildAttributeTextField() {
    return SizedBox(
      height: 80,
      child: TextFormField(
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

  Widget _buildAddAttributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
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

  Widget _buildAttributesList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,

      itemBuilder: (_, _) => const SizedBox(height: AppSizes.spaceBtwItems),
      separatorBuilder: (_, i) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: const Text('Color'),
            subtitle: const Text('Green, Orange, Pink'),
            trailing: IconButton(
              onPressed: () {},
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
