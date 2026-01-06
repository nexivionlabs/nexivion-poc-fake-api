import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../core/util/api_constant/api_constant.dart';
import '../../../core/util/network/base_api.dart';
import '../model/product_model.dart';

/// Service class responsible for product-related API operations
@lazySingleton
class ProductService {
  final ApiBase _apiBase;

  ProductService(this._apiBase);

  /// Fetches all products from the API
  ///
  /// Returns a list of [Product] objects
  /// Throws an [Exception] if the request fails
  Future<List<Product>> fetchProducts() async {
    try {
      log('ProductService: Fetching all products');

      final response = await _apiBase.get(ApiConstants.products);

      if (response.data is List) {
        final products = (response.data as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        log('ProductService: Successfully fetched ${products.length} products');
        return products;
      }

      log('ProductService: Unexpected response format');
      throw Exception('Beklenmeyen veri formatı');
    } catch (e) {
      log('ProductService: Error fetching products - $e');
      rethrow;
    }
  }

  /// Fetches products with pagination
  ///
  /// [limit] - Number of products to fetch
  /// [skip] - Number of products to skip (for pagination)
  ///
  /// Returns a list of [Product] objects
  /// Throws an [Exception] if the request fails
  Future<List<Product>> fetchProductsPaginated({
    required int limit,
    int skip = 0,
  }) async {
    try {
      log('ProductService: Fetching products with limit=$limit, skip=$skip');

      final response = await _apiBase.get(
        ApiConstants.products,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.data is List) {
        final products = (response.data as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        log('ProductService: Successfully fetched ${products.length} products');
        return products;
      }

      log('ProductService: Unexpected response format');
      throw Exception('Beklenmeyen veri formatı');
    } catch (e) {
      log('ProductService: Error fetching paginated products - $e');
      rethrow;
    }
  }

  /// Fetches a single product by ID
  ///
  /// [id] - Product ID
  ///
  /// Returns a [Product] object
  /// Throws an [Exception] if the request fails
  Future<Product> fetchProductById(int id) async {
    try {
      log('ProductService: Fetching product with id=$id');

      final response = await _apiBase.get('${ApiConstants.products}/$id');

      if (response.data is Map<String, dynamic>) {
        final product = Product.fromJson(response.data);
        log('ProductService: Successfully fetched product ${product.title}');
        return product;
      }

      log('ProductService: Unexpected response format');
      throw Exception('Beklenmeyen veri formatı');
    } catch (e) {
      log('ProductService: Error fetching product by id - $e');
      rethrow;
    }
  }

  /// Fetches all product categories
  ///
  /// Returns a list of category names
  /// Throws an [Exception] if the request fails
  Future<List<String>> fetchCategories() async {
    try {
      log('ProductService: Fetching categories');

      final response = await _apiBase.get('${ApiConstants.products}/categories');

      if (response.data is List) {
        final categories = (response.data as List)
            .map((category) => category.toString())
            .toList();

        log('ProductService: Successfully fetched ${categories.length} categories');
        return categories;
      }

      log('ProductService: Unexpected response format');
      throw Exception('Beklenmeyen veri formatı');
    } catch (e) {
      log('ProductService: Error fetching categories - $e');
      rethrow;
    }
  }

  /// Fetches products by category
  ///
  /// [category] - Category name
  ///
  /// Returns a list of [Product] objects
  /// Throws an [Exception] if the request fails
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      log('ProductService: Fetching products for category=$category');

      final response = await _apiBase.get(
        '${ApiConstants.products}/category/$category',
      );

      if (response.data is List) {
        final products = (response.data as List)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        log('ProductService: Successfully fetched ${products.length} products for category $category');
        return products;
      }

      log('ProductService: Unexpected response format');
      throw Exception('Beklenmeyen veri formatı');
    } catch (e) {
      log('ProductService: Error fetching products by category - $e');
      rethrow;
    }
  }
}
