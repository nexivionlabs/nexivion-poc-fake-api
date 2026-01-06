import 'package:flutter/material.dart';

import '../../../../core/product/main_image_builder.dart';
import '../../../../core/util/app_color/app_color.dart';
import '../../../../core/util/app_txt_style/app_txt_style.dart';
import '../../../../core/util/extension/context_extension.dart';
import '../../model/product_model.dart';

/// A modern card widget that displays product information in a grid layout
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Favorite Button
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  // Image Container
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(context.screenWidth * 0.04),
                        child: MainImageBuilder(
                          imagePath: product.image,
                          isNetworkImage: true,
                          fit: BoxFit.contain,
                          loadingWidget: const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.greyMedium,
                              size: context.screenWidth * 0.08,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Category Badge
                  Positioned(
                    top: context.screenWidth * 0.025,
                    left: context.screenWidth * 0.025,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.022,
                        vertical: context.screenWidth * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        product.category.toUpperCase(),
                        style: AppTextStyle.productCardCategoryBadgeTxtStyle(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Rating Badge
                  Positioned(
                    bottom: context.screenWidth * 0.025,
                    right: context.screenWidth * 0.025,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.02,
                        vertical: context.screenWidth * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: context.screenWidth * 0.032,
                            color: AppColors.warning,
                          ),
                          SizedBox(width: context.screenWidth * 0.008),
                          Text(
                            product.rating.rate.toStringAsFixed(1),
                            style: AppTextStyle.productCardRatingTxtStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Details
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(context.screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Expanded(
                      child: Text(
                        product.title,
                        style: AppTextStyle.productCardTitleTxtStyle(context),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: context.screenWidth * 0.02),

                    // Divider
                    Container(
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
                    ),

                    SizedBox(height: context.screenWidth * 0.02),

                    // Price and Add to Cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fiyat',
                                style: AppTextStyle.productCardPriceLabelTxtStyle(context),
                              ),
                              SizedBox(height: context.screenWidth * 0.005),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: AppTextStyle.productCardPriceTxtStyle(context),
                              ),
                            ],
                          ),
                        ),

                        // View Button
                        Container(
                          padding: EdgeInsets.all(context.screenWidth * 0.025),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                AppColors.primaryDark,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: context.screenWidth * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
