import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_sizes.dart';
import '../widgets/header_and_form.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: HeaderAndForm(),
      ),
    );
  }
}
