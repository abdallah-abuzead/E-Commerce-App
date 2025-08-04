import 'package:ecommerce_admin_panel/data/repositories/products/products_repository.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_sizes.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find<CreateProductController>();

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
  final TextEditingController stock = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController salePrice = TextEditingController();
  final TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for tracking different tasks
  final RxBool thumbnailUploader = false.obs;
  final RxBool additionalImagesUploader = false.obs;
  final RxBool productDataUploader = false.obs;
  final RxBool categoriesRelationshipUploader = false.obs;

  // Function to create a new product
  Future<void> createProduct() async {
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
      final ProductImagesController imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) {
        throw 'Please select product thumbnail image.';
      }

      // Additional product images
      additionalImagesUploader.value = true;

      // Product variation images
      final variations = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations and then changed product type to single, remove all variations,
        ProductVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      // Map product data to ProductModel
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
        productType: productType.value.name,
        productAttributes: ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
      );

      // Call repository to create new product
      productDataUploader.value = true;
      newRecord.id = await productsRepository.createProduct(newRecord);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing data. Try again';

        // Loop through selected product categories
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Meta data
          final ProductCategoryModel productCategory = ProductCategoryModel(
            productId: newRecord.id,
            categoryId: category.id,
          );
          await productsRepository.createProductCategory(productCategory);
        }
      }

      // Update products list
      ProductsController.instance.addItemToLists(newRecord);

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
            title: const Text('Creating Product'),
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
            const Text('Your product has been created.'),
          ],
        ),
      ),
    );
  }
}
