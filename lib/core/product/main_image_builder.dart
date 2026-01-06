import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainImageBuilder extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final bool isPng;
  final bool isNetworkImage;
  final bool isSvg;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final BorderRadius? borderRadius;

  const MainImageBuilder({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.isPng = false,
    this.isNetworkImage = false,
    this.isSvg = false,
    this.errorWidget,
    this.loadingWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return _buildErrorWidget();
    }

    Widget imageWidget;
    if (isSvg) {
      imageWidget = _buildSvgImage();
    } else if (isNetworkImage) {
      imageWidget = _buildNetworkImage();
    } else {
      imageWidget = _buildLocalImage();
    }

    return borderRadius != null
        ? ClipRRect(
      borderRadius: borderRadius!,
      child: imageWidget,
    )
        : imageWidget;
  }

  Widget _buildSvgImage() {
    if (isNetworkImage) {
      return SvgPicture.network(
        imagePath!,
        width: width,
        height: height,
        colorFilter:
        color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: fit ?? BoxFit.contain,
        placeholderBuilder: (context) => _buildLoadingWidget(),
      );
    }
    return SvgPicture.asset(
      imagePath!,
      width: width,
      height: height,
      colorFilter:
      color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      fit: fit ?? BoxFit.contain,
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      imagePath!,
      width: width,
      height: height,
      color: color,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingWidget();
      },
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }

  Widget _buildLocalImage() {
    return Image.asset(
      imagePath!,
      width: width,
      height: height,
      color: color,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }

  Widget _buildErrorWidget() {
    return errorWidget ??
        SizedBox(
          width: width,
          height: height,
          child: const Icon(Icons.error_outline, color: Colors.red),
        );
  }

  Widget _buildLoadingWidget() {
    return loadingWidget ??
        SizedBox(
          width: width,
          height: height,
          child: const CircularProgressIndicator(),
        );
  }
}