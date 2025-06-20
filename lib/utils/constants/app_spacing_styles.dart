import 'package:flutter/cupertino.dart';

import 'app_sizes.dart';

abstract class AppSpacingStyles {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
  );
}
