import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/product/main_layout.dart';
import '../../../core/product/main_search_bar.dart';
import '../../../core/util/app_color/app_color.dart';
import '../../../core/util/app_constant/app_constant.dart';
import '../../../core/util/app_txt_style/app_txt_style.dart';
import '../../../core/util/extension/context_extension.dart';
import '../view_model/home_view_model.dart';
import 'widget/empty_state.dart';
import 'widget/error_state.dart';
import 'widget/filter_bottom_sheet.dart';
import 'widget/product_card.dart';

/// Home screen that displays a grid of products with search, filter and pagination
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeView();
    _setupScrollListener();
  }

  void _initializeView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().initialize();
    });
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      // Pagination threshold changed to 60%
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.6) {
        context.read<HomeViewModel>().loadMoreProducts();
      }
    });
  }

  Future<void> _onRefresh() async {
    await context.read<HomeViewModel>().fetchProducts();
  }

  void _onSearchChanged(String value) {
    context.read<HomeViewModel>().updateSearchQuery(value);
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<HomeViewModel>().clearSearch();
  }

  void _showFilterBottomSheet() {
    final viewModel = context.read<HomeViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => FilterBottomSheet(
        categories: viewModel.categories,
        selectedCategory: viewModel.selectedCategory,
        onCategorySelected: (category) {
          if (category == null) {
            viewModel.clearFilter();
          } else {
            viewModel.filterByCategory(category);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return MainLayout(
          backgroundColor: AppColors.background,
          disableSafeArea: false,
          useDefaultPadding: false,
          content: Column(
            children: [
              // Custom AppBar Area
              _buildCustomAppBar(context, viewModel),

              height2Per(context: context),

              // Search and Filter Row
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.04,
                ),
                child: Row(
                  children: [
                    // Search Bar
                    Expanded(
                      child: MainSearchBar(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onClear: _clearSearch,
                        hintText: 'Ürün ara...',
                        showClearButton: viewModel.isSearching,
                      ),
                    ),

                    SizedBox(width: context.screenWidth * 0.03),

                    // Filter Button
                    GestureDetector(
                      onTap: _showFilterBottomSheet,
                      child: Container(
                        padding: EdgeInsets.all(context.screenWidth * 0.035),
                        decoration: BoxDecoration(
                          gradient: viewModel.isFiltered
                              ? LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primaryDark,
                                  ],
                                )
                              : null,
                          color: viewModel.isFiltered ? null : AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: viewModel.isFiltered
                                ? Colors.transparent
                                : AppColors.border,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: viewModel.isFiltered
                                  ? AppColors.primary.withValues(alpha: 0.3)
                                  : AppColors.shadow,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: viewModel.isFiltered
                              ? AppColors.white
                              : AppColors.textPrimary,
                          size: context.screenWidth * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              height3Per(context: context),

              // Filter Info
              if (viewModel.isFiltered)
                _buildFilterInfo(context, viewModel),

              // Search Results Info
              if (viewModel.isSearching && !viewModel.isFiltered)
                _buildSearchResultsInfo(context, viewModel),

              // Content Area
              Expanded(
                child: _buildContent(context, viewModel),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomAppBar(BuildContext context, HomeViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        context.screenWidth * 0.04,
        context.screenWidth * 0.12,
        context.screenWidth * 0.04,
        context.screenWidth * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ürünler',
                style: AppTextStyle.homeAppBarTitleTxtStyle(context),
              ),
              height1Per(context: context),
              Row(
                children: [
                  Text(
                    viewModel.hasProducts
                        ? '${viewModel.products.length} ürün'
                        : 'Yükleniyor...',
                    style: AppTextStyle.homeAppBarSubtitleTxtStyle(context),
                  ),
                  // Connection Status
                  if (!viewModel.isConnected) ...[
                    SizedBox(width: context.screenWidth * 0.02),
                    Icon(
                      Icons.wifi_off,
                      size: context.screenWidth * 0.04,
                      color: AppColors.error,
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Refresh Button
          GestureDetector(
            onTap: viewModel.isLoading ? null : _onRefresh,
            child: Container(
              padding: EdgeInsets.all(context.screenWidth * 0.03),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: viewModel.isLoading
                  ? SizedBox(
                      width: context.screenWidth * 0.05,
                      height: context.screenWidth * 0.05,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                      size: context.screenWidth * 0.06,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterInfo(BuildContext context, HomeViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.04,
      ),
      padding: EdgeInsets.all(context.screenWidth * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primaryDark.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.filter_alt,
            size: context.screenWidth * 0.045,
            color: AppColors.primary,
          ),
          SizedBox(width: context.screenWidth * 0.02),
          Expanded(
            child: Text(
              'Filtre: ${viewModel.selectedCategory?.toUpperCase()} • ${viewModel.products.length} ürün',
              style: AppTextStyle.homeFilterInfoTxtStyle(context),
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.clearFilter(),
            child: Icon(
              Icons.close,
              size: context.screenWidth * 0.05,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsInfo(BuildContext context, HomeViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.04,
      ),
      padding: EdgeInsets.all(context.screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: context.screenWidth * 0.045,
            color: AppColors.info,
          ),
          SizedBox(width: context.screenWidth * 0.02),
          Expanded(
            child: Text(
              '${viewModel.products.length} sonuç bulundu',
              style: AppTextStyle.homeSearchResultsInfoTxtStyle(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeViewModel viewModel) {
    // Loading State
    if (viewModel.isLoading) {
      return _buildLoadingState(context);
    }

    // Error State
    if (viewModel.errorMessage != null) {
      return _buildErrorState(viewModel);
    }

    // Empty State
    if (!viewModel.hasProducts) {
      return _buildEmptyState(viewModel);
    }

    // Products Grid with RefreshIndicator
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.primary,
      child: _buildProductsGrid(context, viewModel),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          height3Per(context: context),
          Text(
            'Ürünler yükleniyor...',
            style: AppTextStyle.homeLoadingTxtStyle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(HomeViewModel viewModel) {
    return ErrorState(
      message: viewModel.errorMessage!,
      onRetry: viewModel.retry,
    );
  }

  Widget _buildEmptyState(HomeViewModel viewModel) {
    if (viewModel.isSearching || viewModel.isFiltered) {
      return EmptyState(
        icon: Icons.search_off,
        message: 'Sonuç Bulunamadı',
        description: 'Aradığınız kriterlere uygun ürün bulunamadı.',
        actionLabel: viewModel.isFiltered ? 'Filtreyi Temizle' : 'Aramayı Temizle',
        onAction: () {
          if (viewModel.isFiltered) {
            viewModel.clearFilter();
          } else {
            _clearSearch();
          }
        },
      );
    }

    return EmptyState(
      message: 'Henüz Ürün Yok',
      description: 'Görüntülenecek ürün bulunmamaktadır.',
      actionLabel: 'Yenile',
      onAction: viewModel.retry,
    );
  }

  Widget _buildProductsGrid(BuildContext context, HomeViewModel viewModel) {
    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(context.screenWidth * 0.04),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: context.screenWidth * 0.03,
        mainAxisSpacing: context.screenWidth * 0.04,
      ),
      itemCount: viewModel.products.length + (viewModel.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == viewModel.products.length) {
          return _buildLoadingMoreIndicator(context);
        }

        final product = viewModel.products[index];
        return ProductCard(
          product: product,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/product-detail',
              arguments: product,
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingMoreIndicator(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.screenWidth * 0.04),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}
