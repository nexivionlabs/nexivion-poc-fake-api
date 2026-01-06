import 'package:flutter/material.dart';

import '../util/app_color/app_color.dart';
import '../util/extension/context_extension.dart';

/// Reusable search bar widget
class MainSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final bool showClearButton;

  const MainSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.hintText = 'Ara...',
    this.showClearButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: context.screenWidth * 0.04,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textDisabled,
            fontSize: context.screenWidth * 0.04,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.greyMedium,
            size: context.screenWidth * 0.06,
          ),
          suffixIcon: showClearButton
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.greyMedium,
                    size: context.screenWidth * 0.06,
                  ),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.04,
            vertical: context.screenWidth * 0.035,
          ),
        ),
      ),
    );
  }
}
