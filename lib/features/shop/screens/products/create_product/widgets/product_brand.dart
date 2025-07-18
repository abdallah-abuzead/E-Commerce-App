import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/app_images.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Lable
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // TypeAheadField for brand selection
          TypeAheadField(
            builder: (context, ctr, focusedNode) {
              return TextFormField(
                focusNode: focusedNode,
                decoration: const InputDecoration(
                  labelText: 'Select Brand',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Iconsax.box),
                ),
              );
            },

            suggestionsCallback: (pattern) {
              return [
                BrandModel(id: 'id', image: AppImages.acerLogo, name: 'Acer'),
                BrandModel(id: 'id', image: AppImages.acerLogo, name: 'Adidas'),
              ];
            },
            itemBuilder: (context, suggestion) {
              return ListTile(title: Text(suggestion.name));
            },
            onSelected: (suggestion) {},
          ),
        ],
      ),
    );
  }
}
