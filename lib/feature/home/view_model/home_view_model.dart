import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/service/network_checker.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

/// ViewModel for the home screen
///
/// Manages state for product listing, search, pagination, filtering, and error handling
@injectable
class HomeViewModel extends ChangeNotifier {
  final ProductService _productService;
  final NetworkChecker _networkChecker;

  HomeViewModel(this._productService, this._networkChecker);

  // State variables
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  String _searchQuery = '';
  String? _selectedCategory;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  int _currentPage = 0;
  bool _hasMoreProducts = true;
  bool _isConnected = true;

  // Pagination configuration
  static const int _productsPerPage = 10;

  // Search debounce timer
  Timer? _debounceTimer;

  // Getters
  List<Product> get products => _filteredProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  bool get hasProducts => _filteredProducts.isNotEmpty;
  bool get hasMoreProducts => _hasMoreProducts;
  String get searchQuery => _searchQuery;
  bool get isSearching => _searchQuery.isNotEmpty;
  bool get isConnected => _isConnected;
  String? get selectedCategory => _selectedCategory;
  bool get isFiltered => _selectedCategory != null;

  /// Initializes the view model and fetches initial products
  Future<void> initialize() async {
    // Check network connection first
    _isConnected = await _networkChecker.hasConnection;

    if (!_isConnected) {
      _errorMessage = 'İnternet bağlantınızı kontrol ediniz';
      notifyListeners();
      return;
    }

    // Start listening to network changes
    _networkChecker.startListening(_onNetworkChanged);

    await fetchProducts();
    await _fetchCategories();
  }

  /// Network connectivity changed callback
  void _onNetworkChanged(bool isConnected) {
    log('HomeViewModel: Network changed - Connected: $isConnected');
    _isConnected = isConnected;

    if (!isConnected) {
      _errorMessage = 'İnternet bağlantınızı kontrol ediniz';
    } else {
      _errorMessage = null;
      if (_allProducts.isEmpty) {
        fetchProducts();
      }
    }
    notifyListeners();
  }

  /// Fetches categories from the API
  Future<void> _fetchCategories() async {
    try {
      log('HomeViewModel: Fetching categories');
      _categories = await _productService.fetchCategories();
      log('HomeViewModel: Successfully loaded ${_categories.length} categories');
    } catch (e) {
      log('HomeViewModel: Error fetching categories - $e');
    }
  }

  /// Fetches products from the API
  Future<void> fetchProducts() async {
    try {
      // Check connection first
      _isConnected = await _networkChecker.hasConnection;
      if (!_isConnected) {
        _errorMessage = 'İnternet bağlantınızı kontrol ediniz';
        _isLoading = false;
        notifyListeners();
        return;
      }

      _isLoading = true;
      _errorMessage = null;
      _currentPage = 0;
      _hasMoreProducts = true;
      notifyListeners();

      log('HomeViewModel: Fetching products');

      List<Product> products;

      if (_selectedCategory != null) {
        products = await _productService.fetchProductsByCategory(_selectedCategory!);
      } else {
        products = await _productService.fetchProducts();
      }

      _allProducts = products;
      _applyFilters();

      _isLoading = false;
      notifyListeners();

      log('HomeViewModel: Successfully loaded ${products.length} products');
    } catch (e) {
      log('HomeViewModel: Error fetching products - $e');
      _isLoading = false;
      _errorMessage = _parseErrorMessage(e);
      notifyListeners();
    }
  }

  /// Loads more products for pagination
  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMoreProducts || _isLoading) {
      return;
    }

    try {
      _isLoadingMore = true;
      notifyListeners();

      log('HomeViewModel: Loading more products');

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final nextPage = _currentPage + 1;
      final startIndex = nextPage * _productsPerPage;

      List<Product> sourceProducts = _searchQuery.isEmpty && _selectedCategory == null
          ? _allProducts
          : _getFilteredSourceProducts();

      if (startIndex >= sourceProducts.length) {
        _hasMoreProducts = false;
        _isLoadingMore = false;
        notifyListeners();
        log('HomeViewModel: No more products to load');
        return;
      }

      _currentPage = nextPage;
      _applyFilters();

      _isLoadingMore = false;
      notifyListeners();

      log('HomeViewModel: Loaded more products, current page: $_currentPage');
    } catch (e) {
      log('HomeViewModel: Error loading more products - $e');
      _isLoadingMore = false;
      _errorMessage = _parseErrorMessage(e);
      notifyListeners();
    }
  }

  /// Updates the search query and filters products
  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    log('HomeViewModel: Search query updated to: $_searchQuery');

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _currentPage = 0;
      _hasMoreProducts = true;
      _applyFilters();
      notifyListeners();
    });
  }

  /// Clears the search query and shows all products
  void clearSearch() {
    _searchQuery = '';
    _currentPage = 0;
    _hasMoreProducts = true;
    _applyFilters();
    notifyListeners();
    log('HomeViewModel: Search cleared');
  }

  /// Filters products by category
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _currentPage = 0;
    _hasMoreProducts = true;
    log('HomeViewModel: Filtering by category: $category');

    fetchProducts();
  }

  /// Clears category filter
  void clearFilter() {
    _selectedCategory = null;
    _currentPage = 0;
    _hasMoreProducts = true;
    log('HomeViewModel: Filter cleared');

    fetchProducts();
  }

  /// Gets filtered source products based on search and category
  List<Product> _getFilteredSourceProducts() {
    List<Product> source = _allProducts;

    if (_searchQuery.isNotEmpty) {
      source = source.where((product) {
        return product.title.toLowerCase().contains(_searchQuery) ||
            product.description.toLowerCase().contains(_searchQuery) ||
            product.category.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    return source;
  }

  /// Applies search and pagination filters
  void _applyFilters() {
    List<Product> sourceProducts = _getFilteredSourceProducts();

    final endIndex = (_currentPage + 1) * _productsPerPage;
    _filteredProducts = sourceProducts.take(endIndex).toList();
    _hasMoreProducts = endIndex < sourceProducts.length;

    log('HomeViewModel: Filtered products count: ${_filteredProducts.length}');
  }

  /// Retries fetching products after an error
  Future<void> retry() async {
    await fetchProducts();
  }

  /// Parses error messages from exceptions
  String _parseErrorMessage(dynamic error) {
    if (error is Exception) {
      final message = error.toString().replaceFirst('Exception: ', '');
      return message;
    }
    return 'Bir hata oluştu. Lütfen tekrar deneyiniz.';
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _networkChecker.dispose();
    super.dispose();
  }
}
