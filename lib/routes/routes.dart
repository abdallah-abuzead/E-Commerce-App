abstract class Routes {
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String resetPassword = '/reset-password';

  static const String dashboard = '/shop';
  static const String media = '/media';
  static const String banners = '/banners';
  static const String responsiveDesign = '/responsive-design';

  static const List<String> sidebarMenuRoutes = [dashboard, media, banners];

  static const String unknown = '/unknown';
}
