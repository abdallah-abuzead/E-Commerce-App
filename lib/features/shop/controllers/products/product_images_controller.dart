import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController instance = Get.find<ProductImagesController>();

  // Rx Observables for the selected thumbnail images
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // List to store additional product images
  RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Pick Thumbnail Image from Media
  Future<void> selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    final List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      final ImageModel selectedImage = selectedImages.first;
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  /// Pick Multiple Images from Media
  Future<void> selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    final List<ImageModel>? selectedImages = await controller.selectImagesFromMedia(
      multipleSelection: true,
      selectedUrls: additionalProductImagesUrls,
    );
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((image) => image.url));
    }
  }

  /// Function to Remove Product Image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }

  /// Pick Variation Image from Media
  Future<void> selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    final List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      final ImageModel selectedImage = selectedImages.first;
      variation.image.value = selectedImage.url;
    }
  }
}
