import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../appbar/app_page_heading.dart';

class BreadcrumbWithHeading extends StatelessWidget {
  const BreadcrumbWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbItems,
    this.returnToPreviousScreen = false,
  });

  // The Heading for the page
  final String heading;

  // List of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(Routes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),
            ...breadcrumbItems.map((item) {
              final bool isLastItem = item == breadcrumbItems.last;
              return Row(
                children: [
                  const Text('/'),
                  InkWell(
                    onTap: isLastItem ? null : () => Get.toNamed(item),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.xs),
                      child: Text(
                        isLastItem
                            ? item.capitalize.toString()
                            : item.substring(1).capitalizeFirst.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        const SizedBox(height: AppSizes.sm), // Space between breadcrumbs and heading
        // Heading of the page
        Row(
          children: [
            if (returnToPreviousScreen)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSizes.spaceBtwItems),
                child: IconButton(
                  icon: const Icon(Iconsax.arrow_left),
                  onPressed: () => Get.back(),
                ),
              ),
            AppPageHeading(heading: heading),
          ],
        ),
      ],
    );
  }
}
