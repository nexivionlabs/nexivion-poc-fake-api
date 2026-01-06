import 'package:flutter/material.dart';

import '../../../../core/product/main_btn.dart';
import '../../../../core/util/app_color/app_color.dart';
import '../../../../core/util/app_constant/app_constant.dart';
import '../../../../core/util/app_txt_style/app_txt_style.dart';
import '../../../../core/util/extension/context_extension.dart';

/// Filter bottom sheet for category selection
class FilterBottomSheet extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onCategorySelected;

  const FilterBottomSheet({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _tempSelectedCategory;

  @override
  void initState() {
    super.initState();
    _tempSelectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: context.screenWidth * 0.03),
            width: context.screenWidth * 0.12,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          height3Per(context: context),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kategori Filtrele',
                  style: AppTextStyle.filterBottomSheetTitleTxtStyle(context),
                ),
                if (_tempSelectedCategory != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tempSelectedCategory = null;
                      });
                    },
                    child: Text(
                      'Temizle',
                      style: AppTextStyle.filterBottomSheetClearTxtStyle(context),
                    ),
                  ),
              ],
            ),
          ),

          height2Per(context: context),

          // Categories List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                final isSelected = _tempSelectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _tempSelectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: context.screenWidth * 0.03),
                    padding: EdgeInsets.all(context.screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.greyLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Radio Icon
                        Container(
                          width: context.screenWidth * 0.05,
                          height: context.screenWidth * 0.05,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.greyMedium,
                              width: 2,
                            ),
                            color: isSelected ? AppColors.primary : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  size: context.screenWidth * 0.03,
                                  color: AppColors.white,
                                )
                              : null,
                        ),

                        SizedBox(width: context.screenWidth * 0.03),

                        // Category Name
                        Expanded(
                          child: Text(
                            category.toUpperCase(),
                            style: AppTextStyle.filterBottomSheetCategoryTxtStyle(
                              context,
                              isSelected: isSelected,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          height3Per(context: context),

          // Apply Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
            child: MainBtn(
              title: 'Filtreyi Uygula',
              onPressed: () {
                widget.onCategorySelected(_tempSelectedCategory);
                Navigator.pop(context);
              },
              btnColor: AppColors.primary,
              textColor: AppColors.white,
              titleFontweight: FontWeight.w600,
            ),
          ),

          height3Per(context: context),
        ],
      ),
    );
  }
}
