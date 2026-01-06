import 'package:flutter/material.dart';

import '../util/app_color/app_color.dart';
import '../util/app_constant/app_assets.dart';
import '../util/app_txt_style/app_txt_style.dart';
import '../util/extension/context_extension.dart';
import 'main_image_builder.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    this.isBackButton = false,
    this.backgroundColor = AppColors.grey,
    this.title,
    this.onBackBtnTapped,
    this.tokenCount = 0,
    this.showTokenCounter = false,
  });

  final bool isBackButton;
  final Color backgroundColor;
  final String? title;
  final VoidCallback? onBackBtnTapped;
  final int tokenCount;
  final bool showTokenCounter;

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // iOS safe area için üstten boşluk
          SizedBox(height: context.screenWidth * 0.12),

          // AppBar içeriği
          Container(
            height: context.screenWidth * 0.15,
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
            child: Stack(
              children: [
                // Back button (positioned on the left)
                if (isBackButton)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onBackBtnTapped ?? () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                        size: context.screenWidth * 0.07,
                      ),
                    ),
                  ),

                // Title (centered across the full width)
                Positioned.fill(
                  child: Center(
                    child: Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.mainAppbarTitleTxtStyle(context),
                    ),
                  ),
                ),

                // Token Counter Box (positioned on the right)
                if (showTokenCounter)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.screenWidth * 0.04,
                          vertical: context.screenWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MainImageBuilder(imagePath: AppAssets.starIcon,isSvg: true,),
                            SizedBox(width: context.screenWidth * 0.02),
                            Text(
                              '$tokenCount',
                              style: TextStyle(
                                color: AppColors.success
                                ,
                                fontSize: context.screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}