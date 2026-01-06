import 'package:flutter/material.dart';

import '../../../core/product/main_back_btn.dart';
import '../../../core/product/main_btn.dart';
import '../../../core/product/main_image_builder.dart';
import '../../../core/product/main_layout.dart';
import '../../../core/util/app_color/app_color.dart';
import '../../../core/util/app_constant/app_constant.dart';
import '../../../core/util/app_txt_style/app_txt_style.dart';
import '../../../core/util/extension/context_extension.dart';
import '../../home/model/product_model.dart';

/// Product detail page showing complete product information
class ProductDetailView extends StatelessWidget {
  final Product product;

  const ProductDetailView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      backgroundColor: AppColors.background,
      disableSafeArea: false,
      useDefaultPadding: false,
      content: Column(
        children: [
          // Custom AppBar
          _buildCustomAppBar(context),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  _buildProductImage(context),

                  height3Per(context: context),

                  // Category Badge
                  _buildCategoryBadge(context),

                  height2Per(context: context),

                  // Product Title
                  _buildProductTitle(context),

                  height2Per(context: context),

                  // Rating and Price Row
                  _buildRatingAndPrice(context),

                  height3Per(context: context),

                  // Divider
                  _buildDivider(),

                  height3Per(context: context),

                  // Description
                  _buildDescription(context),

                  height5Per(context: context),

                  // Add to Cart Button
                  _buildAddToCartButton(context),

                  height3Per(context: context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
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
        children: [
          // Back Button
          MainBackBtn(
            onPressed: () => Navigator.pop(context),
            iconColor: AppColors.white,
            backgroundColor: AppColors.white.withValues(alpha: 0.2),
          ),

          SizedBox(width: context.screenWidth * 0.04),

          // Title
          Expanded(
            child: Text(
              'Ürün Detayı',
              style: AppTextStyle.productDetailAppBarTitleTxtStyle(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenWidth * 0.8,
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(context.screenWidth * 0.08),
          child: MainImageBuilder(
            imagePath: product.image,
            isNetworkImage: true,
            fit: BoxFit.contain,
            loadingWidget: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            errorWidget: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.greyMedium,
                size: 64,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.04,
        vertical: context.screenWidth * 0.02,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        product.category.toUpperCase(),
        style: AppTextStyle.productDetailCategoryBadgeTxtStyle(context),
      ),
    );
  }

  Widget _buildProductTitle(BuildContext context) {
    return Text(
      product.title,
      style: AppTextStyle.productDetailTitleTxtStyle(context),
    );
  }

  Widget _buildRatingAndPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.03,
            vertical: context.screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            color: AppColors.warning,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.warning.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                size: context.screenWidth * 0.05,
                color: AppColors.white,
              ),
              SizedBox(width: context.screenWidth * 0.02),
              Text(
                product.rating.rate.toStringAsFixed(1),
                style: AppTextStyle.productDetailRatingTxtStyle(context),
              ),
              SizedBox(width: context.screenWidth * 0.015),
              Text(
                '(${product.rating.count})',
                style: AppTextStyle.productDetailRatingCountTxtStyle(context),
              ),
            ],
          ),
        ),

        // Price
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.04,
            vertical: context.screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.success,
                AppColors.success.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: AppTextStyle.productDetailPriceTxtStyle(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.border,
            AppColors.border.withValues(alpha: 0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ürün Açıklaması',
          style: AppTextStyle.productDetailDescriptionTitleTxtStyle(context),
        ),
        height2Per(context: context),
        Text(
          product.description,
          style: AppTextStyle.productDetailDescriptionTxtStyle(context),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return MainBtn(
      title: 'Sepete Ekle',
      onPressed: () {
        // Show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} sepete eklendi!'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      btnColor: AppColors.primary,
      textColor: AppColors.white,
      titleFontweight: FontWeight.w700,
      isIcon: const Icon(
        Icons.shopping_cart,
        color: AppColors.white,
      ),
    );
  }
}
