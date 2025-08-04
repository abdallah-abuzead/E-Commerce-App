import 'package:ecommerce_admin_panel/features/shop/controllers/products/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/app_dialogs.dart';

class ProductVariationsController extends GetxController {
  static ProductVariationsController get instance => Get.find<ProductVariationsController>();

  // Observables for loading state and product variations
  final RxBool isLoading = false.obs;
  RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;

  // Lists of controllers for each variation attribute
  final GlobalKey<FormState> variationsFormKey = GlobalKey<FormState>();
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> descriptionControllersList = [];

  final ProductAttributesController attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (final variation in variations) {
      // Stock controllers
      final Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] = TextEditingController(text: variation.stock.toString());
      stockControllersList.add(stockControllers);

      // Price controllers
      final Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] = TextEditingController();
      priceControllersList.add(priceControllers);

      // Sale price controllers
      final Map<ProductVariationModel, TextEditingController> salePriceControllers = {};
      salePriceControllers[variation] = TextEditingController();
      salePriceControllersList.add(salePriceControllers);

      // Description controllers
      final Map<ProductVariationModel, TextEditingController> descriptionControllers = {};
      descriptionControllers[variation] = TextEditingController();
      descriptionControllersList.add(descriptionControllers);
    }
  }

  // Function to remove variations with a confirmation dialog
  void removeVariations(BuildContext context) {
    AppDialogs.defaultDialog(
      context: context,
      title: 'Remove Variations',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  // Function to generate variations with a confirmation dialog
  void generateVariationsConfirmation(BuildContext context) {
    AppDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variations',
      content:
          'Once the variations are created, you cannot add more attributes. In order to add more variations, you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  // Function to generate variations from attributes
  void generateVariationsFromAttributes() {
    Get.back(); // Close the dialog
    final List<ProductVariationModel> variations = [];
    // Check if there are product attributes
    if (attributesController.productAttributes.isNotEmpty) {
      // Get all combinations of attribute values, [[Green, Blue], [Small, Large]]
      final List<List<String>> attributeCombinations = getCombinations(
        attributesController.productAttributes.map((attribute) => attribute.values ?? []).toList(),
      );

      // Generate ProductVariationModel for each combination
      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
          attributesController.productAttributes.map((attr) => attr.name ?? ''),
          combination,
        );
        final variation = ProductVariationModel(
          id: UniqueKey().toString(),
          attributeValues: attributeValues,
        );
        variations.add(variation);

        // Create controllers
        final Map<ProductVariationModel, TextEditingController> stockControllers = {};
        final Map<ProductVariationModel, TextEditingController> priceControllers = {};
        final Map<ProductVariationModel, TextEditingController> salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController> descriptionControllers = {};

        // Assuming variation is your current ProductVariationModel
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        // Add the maps to their respective lists
        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllersList.add(descriptionControllers);
      }
    }

    // Assign the generated variations to the productVariations list
    productVariations.assignAll(variations);
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    // The result list that will store all combinations
    final List<List<String>> result = [];

    // start combining attributes from the first one
    combine(lists, 0, <String>[], result);

    return result;
  }

  // Helper function to recursively combine attributes
  void combine(
    List<List<String>> lists,
    int index,
    List<String> current,
    List<List<String>> result,
  ) {
    // If we reached the end of the lists, add the current combination to the result
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    // Iterate over the values of the current attribute
    for (var item in lists[index]) {
      // create an updated list with the current value added
      final List<String> updated = List.from(current)..add(item);

      // Recursively combine with the next attribute
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }
}
