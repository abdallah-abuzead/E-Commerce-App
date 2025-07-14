import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_sizes.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({super.key, required this.text, required this.selected, this.onSelected});

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final Color? color = null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: color == null ? Text(text) : const SizedBox(),
        labelStyle: TextStyle(color: selected ? Colors.white : null),
        selected: selected,
        onSelected: onSelected,
        avatar: color == null
            ? null
            : AppContainer(width: 50, height: 50, radius: 25, color: color),
        shape: color == null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                side: selected ? BorderSide.none : const BorderSide(color: AppColors.borderPrimary),
              )
            : const CircleBorder(),
        padding: color == null ? null : EdgeInsets.zero,
        labelPadding: color == null ? null : EdgeInsets.zero,
        backgroundColor: color,
      ),
    );
  }
}
