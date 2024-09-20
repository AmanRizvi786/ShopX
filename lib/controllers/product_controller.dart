import 'package:get/state_manager.dart';
import '../models/product_model.dart';
import '../services/remote_services.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <Product>[].obs;
  var favoriteStatus = <int, bool>{}.obs;  // This map tracks favorite status for each product by its ID

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
        // Initialize the favoriteStatus map with false for each product
        for (var product in products) {
          favoriteStatus[product.id] = false;  // Assuming product has an id
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void toggleFavoriteStatus(int productId) {
    if (favoriteStatus.containsKey(productId)) {
      favoriteStatus[productId] = !favoriteStatus[productId]!;  // Toggle the favorite status
    }
  }

  bool isFavorite(int productId) {
    return favoriteStatus[productId] ?? false;  // Return false if not found
  }
}
