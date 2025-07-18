import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_image_uploader.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/app_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_images.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product variations header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Variations', style: Theme.of(context).textTheme.headlineSmall),
              TextButton(onPressed: () {}, child: const Text('Remove Variations')),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Variations List
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            separatorBuilder: (_, _) => const SizedBox(height: AppSizes.spaceBtwItems),
            itemBuilder: (_, _) => _buildVariationsTile(),
          ),

          // No variation message
          _buildNoVariationsMessage(),
        ],
      ),
    );
  }

  Widget _buildVariationsTile() {
    return ExpansionTile(
      backgroundColor: AppColors.lightGrey,
      collapsedBackgroundColor: AppColors.lightGrey,
      childrenPadding: const EdgeInsets.all(AppSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
      title: const Text('Color: Green, Size: Small'),
      children: [
        // upload variation image
        //todo:: wrap with Obx
        AppImageUploader(
          right: 0,
          left: null,
          imageType: ImageType.asset,
          image: AppImages.defaultImage,
          onIconButtonPressed: () {},
        ),

        const SizedBox(height: AppSizes.spaceBtwInputFields),

        // Variations Stock, and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),

        // Variations description
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add description of this variation...',
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: AppImages.defaultVariationsImageIcon,
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        Text('There are no variations added for this product'),
      ],
    );
  }
}
