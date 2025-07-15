abstract class Routes {
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String resetPassword = '/reset-password';

  static const String dashboard = '/dashboard';
  static const String media = '/media';

  static const String categories = '/categories';
  static const String createCategory = '/createCategory';
  static const String editCategory = '/editCategory';

  static const String brands = '/brands';
  static const String createBrand = '/createBrand';
  static const String editBrand = '/editBrand';

  static const String banners = '/banners';
  static const String createBanner = '/createBanner';
  static const String editBanner = '/editBanner';

  static const String products = '/products';
  static const String createProduct = '/createProduct';
  static const String editProduct = '/editProduct';

  static const String responsiveDesign = '/responsive-design';

  static const List<String> sidebarMenuRoutes = [dashboard, media, categories, brands, banners];

  static const String unknown = '/unknown';
}
