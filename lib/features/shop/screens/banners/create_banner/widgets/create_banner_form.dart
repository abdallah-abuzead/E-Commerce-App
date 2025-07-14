import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/chips/app_choice_chip.dart';
import '../../../../../../common/widgets/containers/app_container.dart';
import '../../../../../../common/widgets/images/app_image_uploader.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_sizes.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/validators/validator.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

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
            Text('Create New Banner', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              validator: (value) => Validator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Banner Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Text('Select Categories', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spaceBtwInputFields / 2),
            Wrap(
              spacing: AppSizes.sm,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: AppChoiceChip(text: 'Shoes', selected: true, onSelected: (value) {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: AppChoiceChip(
                    text: 'Track Suits',
                    selected: false,
                    onSelected: (value) {},
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
              child: ElevatedButton(onPressed: () {}, child: const Text('Create')),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
