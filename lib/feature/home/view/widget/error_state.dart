import 'package:flutter/material.dart';

import '../../../../core/product/main_btn.dart';
import '../../../../core/util/app_color/app_color.dart';
import '../../../../core/util/app_constant/app_constant.dart';
import '../../../../core/util/app_txt_style/app_txt_style.dart';
import '../../../../core/util/extension/context_extension.dart';

/// A widget that displays an error state with an icon, message, and retry button
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon Container
            Container(
              width: context.screenWidth * 0.3,
              height: context.screenWidth * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.error.withValues(alpha: 0.2),
                    AppColors.error.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: context.screenWidth * 0.15,
                color: AppColors.error,
              ),
            ),

            height5Per(context: context),

            // Error Title
            Text(
              'Bir Hata Oluştu',
              style: AppTextStyle.errorStateTitleTxtStyle(context),
              textAlign: TextAlign.center,
            ),

            height2Per(context: context),

            // Error Message
            Text(
              message,
              style: AppTextStyle.errorStateMessageTxtStyle(context),
              textAlign: TextAlign.center,
            ),

            height5Per(context: context),

            // Retry Button
            MainBtn(
              title: 'Tekrar Dene',
              onPressed: onRetry,
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
        ),
      ),
    );
  }
}
