import 'package:flutter/material.dart';

import '../util/app_color/app_color.dart';
import '../util/extension/context_extension.dart';

/// Reusable back button widget
class MainBackBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;

  const MainBackBtn({
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        width: size ?? context.screenWidth * 0.1,
        height: size ?? context.screenWidth * 0.1,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: iconColor ?? AppColors.textPrimary,
            size: context.screenWidth * 0.05,
          ),
        ),
      ),
    );
  }
}
