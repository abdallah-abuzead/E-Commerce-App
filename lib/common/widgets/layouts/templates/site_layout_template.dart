import 'package:ecommerce_admin_panel/common/widgets/responsive/app_responsive_design_widget.dart';
import 'package:ecommerce_admin_panel/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:ecommerce_admin_panel/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:ecommerce_admin_panel/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:flutter/cupertino.dart';

class SiteLayoutTemplate extends StatelessWidget {
  const SiteLayoutTemplate({
    super.key,
    this.desktop,
    this.tablet,
    this.mobile,
    this.useLayout = true,
  });
  final Widget? tablet;
  final Widget? desktop;
  final Widget? mobile;
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDesignWidget(
      desktop: useLayout
          ? DesktopLayout(body: desktop)
          : desktop ?? const SizedBox.shrink(),
      tablet: useLayout
          ? TabletLayout(body: tablet ?? desktop)
          : tablet ?? desktop ?? const SizedBox.shrink(),
      mobile: useLayout
          ? MobileLayout(body: mobile ?? desktop)
          : mobile ?? tablet ?? desktop ?? const SizedBox.shrink(),
    );
  }
}
