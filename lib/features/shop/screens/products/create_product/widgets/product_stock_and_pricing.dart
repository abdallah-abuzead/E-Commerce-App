import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: 0.45,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Stock',
                hintText: 'Add Stock, only numbers are allowed',
              ),
              validator: (value) => Validator.validateEmptyText('Stock', value),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Pricing
          Row(
            children: [
              // Price
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with up-to 2 decimals',
                  ),
                  validator: (value) => Validator.validateEmptyText('Price', value),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),

              // Sale Price
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Discounted Price',
                    hintText: 'Price with up-to 2 decimals',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
