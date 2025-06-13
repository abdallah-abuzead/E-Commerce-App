import 'package:ecommerce_admin_panel/widgets/desktop_layout.dart';
import 'package:ecommerce_admin_panel/widgets/mobile_layout.dart';
import 'package:ecommerce_admin_panel/widgets/responsive_widget.dart';
import 'package:ecommerce_admin_panel/widgets/tablet_layout.dart';
import 'package:flutter/cupertino.dart';

class SiteLayout extends StatelessWidget {
  const SiteLayout({
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
    return ResponsiveWidget(
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
