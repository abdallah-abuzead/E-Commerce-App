import 'package:ecommerce_admin_panel/data/repositories/products/products_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/categories/categories_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/product_images_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/products/products_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_loaders.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_sizes.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find<EditProductController>();
  final ProductImagesController imagesController = Get.put(ProductImagesController());
  final ProductVariationsController variationsController = Get.put(ProductVariationsController());
  final ProductAttributesController attributesController = Get.put(ProductAttributesController());

  // Observables for loading state and product details
  final RxBool isLoading = false.obs;
  final Rx<ProductType> productType = ProductType.single.obs;
  final Rx<ProductVisibility> productVisibility = ProductVisibility.hidden.obs;

  // Controllers and keys
  final GlobalKey<FormState> stockPriceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> titleDescriptionFormKey = GlobalKey<FormState>();
  final ProductsRepository productsRepository = Get.put(ProductsRepository());

  // Text editing controllers for input fields
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController stock = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController salePrice = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  // Flags for tracking different tasks
  final RxBool thumbnailUploader = false.obs;
  final RxBool productDataUploader = false.obs;
  final RxBool additionalImagesUploader = false.obs;
  final RxBool categoriesRelationshipUploader = false.obs;
  final RxBool selectedCategoriesLoader = false.obs;

  void initProductData(ProductModel product) {
    try {
      isLoading.value = true; // Set loading state to true while initializing data

      // Basic information
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.variable.name
          ? ProductType.variable
          : ProductType.single;

      // Stock and pricing (assuming productType and productVisibility are handled elsewhere)
      if (product.productType == ProductType.single.name) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Product brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      // Product Thumbnail and additional images
      if (product.images != null) {
        // Set the first image as the thumbnail
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;

        // Set additional images
        imagesController.additionalProductImagesUrls.assignAll(product.images ?? []);
      }

      // Product attributes and variations (assuming that you have a method to fetch variations in ProductVariationsController)
      attributesController.productAttributes.assignAll(product.productAttributes ?? []);
      variationsController.productVariations.assignAll(product.productVariations ?? []);
      variationsController.initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false; // Set loading state to false after initializing data
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;
    // Product categories
    final List<ProductCategoryModel> productCategories = await productsRepository
        .getProductCategories(productId);
    final categoriesController = Get.put(CategoriesController());
    if (categoriesController.allItems.isEmpty) await categoriesController.fetchItems();

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories = categoriesController.allItems
        .where((category) => categoriesIds.contains(category.id))
        .toList();
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  // Function to edit product
  Future<void> editProduct(ProductModel product) async {
    try {
      // Show progress dialog
      showProgressDialog();

      // Check internet connectivity
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      // Validate title adn description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Validate stock and price form if productType == single
      if (productType.value == ProductType.single && !stockPriceFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Ensure a brand is selected
      if (selectedBrand.value == null) throw 'Select brand for this product';

      // Check variation data id productType == variable
      if (productType.value == ProductType.variable &&
          ProductVariationsController.instance.productVariations.isEmpty) {
        throw 'There are no variations for this product type (variable). Create some variations or change product type.';
      }
      if (productType.value == ProductType.variable) {
        final bool variationCheckFailed = ProductVariationsController.instance.productVariations
            .any(
              (variation) =>
                  variation.price.isNaN ||
                  variation.salePrice < 0 ||
                  variation.price.isNaN ||
                  variation.salePrice < 0 ||
                  variation.stock.isNaN ||
                  variation.stock < 0 ||
                  variation.image.value.isEmpty,
            );
        if (variationCheckFailed) {
          throw 'Variation data is not accurate. Please recheck variations.';
        }
      }

      // Upload product thumbnail image
      thumbnailUploader.value = true;
      if (imagesController.selectedThumbnailImageUrl.value == null ||
          imagesController.selectedThumbnailImageUrl.value!.isEmpty) {
        throw 'Upload product thumbnail image.';
      }

      // Additional product images
      additionalImagesUploader.value = true;

      // Product variation images if any
      final variations = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations and then changed product type to single, remove all variations,
        ProductVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      product.sku = '';
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.name;
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImagesUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
      product.productAttributes = ProductAttributesController.instance.productAttributes;
      product.productVariations = variations;

      // Call repository to update product
      productDataUploader.value = true;
      await productsRepository.updateProduct(product);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        // Loop through selected product categories
        categoriesRelationshipUploader.value = true;

        // Get the existing categories ids
        final List<String> existingCategoriesIds = alreadyAddedCategories.map((e) => e.id).toList();

        for (var category in selectedCategories) {
          // Check if the category is not already associated with the product
          if (!existingCategoriesIds.contains(category.id)) {
            // Meta data
            final ProductCategoryModel productCategory = ProductCategoryModel(
              productId: product.id,
              categoryId: category.id,
            );
            await productsRepository.createProductCategory(productCategory);
          }
        }

        // Remove categories not selected by the user
        for (var existingCategoryId in existingCategoriesIds) {
          // Check if the category is not present in the selected categories
          if (!selectedCategories.any((category) => category.id == existingCategoryId)) {
            // Remove the association
            await productsRepository.removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      // Update products list
      ProductsController.instance.updateItemInLists(product);

      // Close the progress loader
      FullScreenLoader.stopLoading();

      // Show success message loader
      showCompletionDialog();
    } catch (e) {
      FullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    description.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductImagesController.instance.selectedThumbnailImageUrl.value = null;
    ProductImagesController.instance.additionalProductImagesUrls.clear();
    ProductVariationsController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

    // Reset upload flags
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  // show the progress dialog
  Future<void> showProgressDialog() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text('Updating Product'),
            content: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.creatingProductIllustration, height: 200, width: 200),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  buildCheckbox('Thumbnail Image', thumbnailUploader),
                  buildCheckbox('Additional Images', additionalImagesUploader),
                  buildCheckbox('Product Data, Attributes & Variations', productDataUploader),
                  buildCheckbox('Product Categories', categoriesRelationshipUploader),
                  Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
                  const Text('Sit tight, your product is uploading...'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        Text(label),
      ],
    );
  }

  // show the completion dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.back(); // Navigate back to the previous screen
            },
            child: const Text('Go to Products'),
          ),
        ],

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.productIllustration, height: 200, width: 200),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const Text('Your product has been updated.'),
          ],
        ),
      ),
    );
  }
}
