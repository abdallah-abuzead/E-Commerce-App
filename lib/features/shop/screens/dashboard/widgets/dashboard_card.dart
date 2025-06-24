import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/app_section_heading.dart';
import '../../../../../common/widgets/containers/app_container.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_sizes.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stats,
    this.icon = Iconsax.arrow_up_3,
    this.color = AppColors.success,
    this.onTap,
  });

  final String title, subtitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          /// Section Heading
          AppSectionHeading(title: title, textColor: AppColors.textSecondary),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle, style: Theme.of(context).textTheme.headlineMedium),

              /// Right side widget
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(icon, color: color, size: AppSizes.iconXs),
                      Text(
                        '$stats%',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 13,
                          color: color,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to Dec 2025',
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
