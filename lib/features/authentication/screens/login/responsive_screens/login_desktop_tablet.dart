import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/login_template.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginDesktopTablet extends StatelessWidget {
  const LoginDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          LoginHeader(),
          // Form
          LoginForm(),
        ],
      ),
    );
  }
}
