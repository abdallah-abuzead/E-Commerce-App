import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:flutter/material.dart';

import '../widgets/header_and_form.dart';

class ForgetPasswordDesktopTablet extends StatelessWidget {
  const ForgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(body: HeaderAndForm());
  }
}
