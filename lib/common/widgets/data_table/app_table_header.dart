import 'package:ecommerce_admin_panel/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppTableHeader extends StatelessWidget {
  const AppTableHeader({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.searchController,
    this.searchOnChange,
  });

  final Function()? onPressed;
  final String buttonText;
  final TextEditingController? searchController;
  final Function(String)? searchOnChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: DeviceUtils.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: onPressed, child: Text(buttonText)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: DeviceUtils.isDesktopScreen(context) ? 2 : 1,

          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChange,
            decoration: const InputDecoration(
              hint: Text('Search here...'),
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ],
    );
  }
}
