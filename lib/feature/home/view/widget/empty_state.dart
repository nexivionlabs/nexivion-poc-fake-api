import 'package:flutter/material.dart';

import '../../../../core/product/main_btn.dart';
import '../../../../core/util/app_color/app_color.dart';
import '../../../../core/util/app_constant/app_constant.dart';
import '../../../../core/util/app_txt_style/app_txt_style.dart';
import '../../../../core/util/extension/context_extension.dart';

/// A widget that displays an empty state with an icon and message
class EmptyState extends StatelessWidget {
  final String message;
  final String? description;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyState({
    super.key,
    required this.message,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              width: context.screenWidth * 0.3,
              height: context.screenWidth * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.greyLight,
                    AppColors.greyLight.withValues(alpha: 0.5),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: context.screenWidth * 0.15,
                color: AppColors.greyMedium,
              ),
            ),

            height5Per(context: context),

            // Message
            Text(
              message,
              style: AppTextStyle.emptyStateMessageTxtStyle(context),
              textAlign: TextAlign.center,
            ),

            if (description != null) ...[
              height2Per(context: context),
              Text(
                description!,
                style: AppTextStyle.emptyStateDescriptionTxtStyle(context),
                textAlign: TextAlign.center,
              ),
            ],

            if (onAction != null && actionLabel != null) ...[
              height5Per(context: context),
              MainBtn(
                title: actionLabel!,
                onPressed: onAction,
                btnColor: AppColors.primary,
                textColor: AppColors.white,
                titleFontweight: FontWeight.w600,
                width: context.screenWidth * 0.6,
                isIcon: const Icon(
                  Icons.refresh,
                  color: AppColors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
