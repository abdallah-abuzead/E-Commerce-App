import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:ecommerce_admin_panel/features/media/screens/media_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/brands_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/create_brand_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/edit_brand_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/customers_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/customer_details_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/products_screen.dart';
import 'package:ecommerce_admin_panel/responsive_design_screen.dart';
import 'package:ecommerce_admin_panel/routes/route_middleware.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';
import '../features/shop/screens/banners/all_banners/banners_screen.dart';
import '../features/shop/screens/banners/create_banner/create_banner_screen.dart';
import '../features/shop/screens/banners/edit_banner/edit_banner_screen.dart';
import '../features/shop/screens/category/all_categories/categories_screen.dart';
import '../features/shop/screens/category/create_category/create_category_screen.dart';
import '../features/shop/screens/category/edit_category/edit_category_screen.dart';
import '../features/shop/screens/dashboard/dashboard_screen.dart';
import '../features/shop/screens/products/create_product/create_product_screen.dart';
import '../features/shop/screens/products/edit_product/edit_product_screen.dart';

class AppRoute {
  static final List<GetPage> pages = [
    // auth
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: Routes.resetPassword, page: () => const ResetPasswordScreen()),

    // dashboard
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // media
    GetPage(name: Routes.media, page: () => const MediaScreen(), middlewares: [RouteMiddleware()]),

    // categories
    GetPage(
      name: Routes.categories,
      page: () => const CategoriesScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createCategory,
      page: () => const CreateCategoryScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editCategory,
      page: () => const EditCategoryScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // brands
    GetPage(
      name: Routes.brands,
      page: () => const BrandsScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createBrand,
      page: () => const CreateBrandScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editBrand,
      page: () => const EditBrandScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // banners
    GetPage(
      name: Routes.banners,
      page: () => const BannersScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createBanner,
      page: () => const CreateBannerScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editBanner,
      page: () => const EditBannerScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // products
    GetPage(
      name: Routes.products,
      page: () => const ProductsScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.createProduct,
      page: () => const CreateProductScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.editProduct,
      page: () => const EditProductScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // customers
    GetPage(
      name: Routes.customers,
      page: () => const CustomersScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.customerDetails,
      page: () => const CustomerDetailsScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // test responsive design
    GetPage(name: Routes.responsiveDesign, page: () => const ResponsiveDesignScreen()),
  ];

  static final unknownRoute = GetPage(name: Routes.unknown, page: () => const UnknownRouteScreen());
}

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(child: Text('404 - Page Not Found')),
    );
  }
}
