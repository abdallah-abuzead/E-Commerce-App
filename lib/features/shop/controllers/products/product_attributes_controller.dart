import 'package:ecommerce_admin_panel/features/shop/controllers/products/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/app_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find<ProductAttributesController>();

  // Observables for loading state, form key, and product attributes
  final RxBool isLoading = false.obs;
  final GlobalKey<FormState> attributesFormKey = GlobalKey<FormState>();
  final TextEditingController attributeName = TextEditingController();
  final TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;

  // Function to add new attribute
  void addNewAttribute() {
    if (!attributesFormKey.currentState!.validate()) return;
    final newAttribute = ProductAttributeModel(
      name: attributeName.text.trim(),
      values: attributes.text.trim().split('|').toList(),
    );
    productAttributes.add(newAttribute);
    attributeName.clear();
    attributes.clear();
  }

  // Function to remove attribute
  void removeAttribute(int index, BuildContext context) {
    AppDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        productAttributes.removeAt(index);
        Get.back();
        // Reset product variations when removing an attribute
        ProductVariationsController.instance.productVariations.value = [];
      },
    );
  }

  // Function to reset product attributes
  void resetProductAttributes() {
    productAttributes.clear();
  }
}
