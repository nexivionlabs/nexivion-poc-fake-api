import 'package:flutter/material.dart';

import '../util/app_color/app_color.dart';
import '../util/extension/context_extension.dart';

/// Reusable button widget following the app's design system
class MainBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? btnColor;
  final Color? textColor;
  final Color? borderColor;
  final FontWeight? titleFontweight;
  final Widget? isIcon;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool isDisabled;

  const MainBtn({
    super.key,
    required this.title,
    this.onPressed,
    this.btnColor,
    this.textColor,
    this.borderColor,
    this.titleFontweight,
    this.isIcon,
    this.width,
    this.height,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = !isDisabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? context.screenWidth * 0.14,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (btnColor ?? AppColors.primary)
              : AppColors.greyLight,
          foregroundColor: textColor ?? AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderColor != null ? 1.5 : 0,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.04,
            vertical: context.screenWidth * 0.03,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: context.screenWidth * 0.04,
                        fontWeight: titleFontweight ?? FontWeight.w600,
                        color: isEnabled
                            ? (textColor ?? AppColors.white)
                            : AppColors.greyMedium,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isIcon != null) ...[
                    SizedBox(width: context.screenWidth * 0.02),
                    isIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
