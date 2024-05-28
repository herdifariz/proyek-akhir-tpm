import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategory() {
    return BaseNetwork.get("products/category");
  }
  Future<Map<String, dynamic>> loadProducts() {
    return BaseNetwork.get("products");
  }
  Future<Map<String, dynamic>> loadProductsByCategory(String category) {
    return BaseNetwork.get("products/category?type=$category");
  }
}