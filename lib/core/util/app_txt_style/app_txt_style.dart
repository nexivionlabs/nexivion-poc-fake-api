import 'package:flutter/material.dart';

import 'package:poc_project_fake_api/core/util/extension/context_extension.dart';

import '../app_color/app_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle onboardTitleTxtStyle(BuildContext context) {
    return TextStyle(
      color: AppColors.grey,
      fontSize: context.screenWidth * 0.066,
      fontWeight: FontWeight.w600,
      fontFamily: "poppins",
    );
  }

  static TextStyle onboardTSubitleTxtStyle(BuildContext context) {
    return TextStyle(
      color: AppColors.textSecondary,
      fontSize: context.screenWidth * 0.04,
      fontWeight: FontWeight.w400,
      fontFamily: "poppins",
    );
  }

  static TextStyle mainAppbarTitleTxtStyle(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontSize: context.screenWidth * 0.05,
      fontWeight: FontWeight.w600,
      fontFamily: "poppins",
    );
  }

  // Home View Text Styles
  static TextStyle homeAppBarTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.065,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
      letterSpacing: 0.5,
      fontFamily: "poppins",
    );
  }

  static TextStyle homeAppBarSubtitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      fontWeight: FontWeight.w400,
      color: AppColors.white.withValues(alpha: 0.9),
      fontFamily: "poppins",
    );
  }

  static TextStyle homeFilterInfoTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      fontFamily: "poppins",
    );
  }

  static TextStyle homeSearchResultsInfoTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      color: AppColors.info,
      fontWeight: FontWeight.w500,
      fontFamily: "poppins",
    );
  }

  static TextStyle homeLoadingTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.04,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w500,
      fontFamily: "poppins",
    );
  }

  // Product Detail Text Styles
  static TextStyle productDetailAppBarTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.05,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
      letterSpacing: 0.5,
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailCategoryBadgeTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.03,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
      letterSpacing: 1,
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.055,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.3,
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailRatingTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.04,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailRatingCountTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      fontWeight: FontWeight.w600,
      color: AppColors.white.withValues(alpha: 0.9),
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailPriceTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.06,
      fontWeight: FontWeight.w800,
      color: AppColors.white,
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailDescriptionTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.045,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: "poppins",
    );
  }

  static TextStyle productDetailDescriptionTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.04,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.6,
      fontFamily: "poppins",
    );
  }

  // Product Card Text Styles
  static TextStyle productCardCategoryBadgeTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.025,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      letterSpacing: 0.3,
      fontFamily: "poppins",
    );
  }

  static TextStyle productCardRatingTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.03,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: "poppins",
    );
  }

  static TextStyle productCardTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.3,
      fontFamily: "poppins",
    );
  }

  static TextStyle productCardPriceLabelTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.025,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
      fontFamily: "poppins",
    );
  }

  static TextStyle productCardPriceTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.045,
      fontWeight: FontWeight.w800,
      color: AppColors.primary,
      fontFamily: "poppins",
    );
  }

  // Empty State Text Styles
  static TextStyle emptyStateMessageTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.05,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: "poppins",
    );
  }

  static TextStyle emptyStateDescriptionTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      color: AppColors.textSecondary,
      height: 1.5,
      fontFamily: "poppins",
    );
  }

  // Error State Text Styles
  static TextStyle errorStateTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.05,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: "poppins",
    );
  }

  static TextStyle errorStateMessageTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      color: AppColors.textSecondary,
      height: 1.5,
      fontFamily: "poppins",
    );
  }

  // Filter Bottom Sheet Text Styles
  static TextStyle filterBottomSheetTitleTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.05,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: "poppins",
    );
  }

  static TextStyle filterBottomSheetClearTxtStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.screenWidth * 0.035,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
      fontFamily: "poppins",
    );
  }

  static TextStyle filterBottomSheetCategoryTxtStyle(
    BuildContext context, {
    required bool isSelected,
  }) {
    return TextStyle(
      fontSize: context.screenWidth * 0.04,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      color: isSelected ? AppColors.primary : AppColors.textPrimary,
      fontFamily: "poppins",
    );
  }
}