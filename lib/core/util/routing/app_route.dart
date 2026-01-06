import 'package:flutter/material.dart';

import '../../../feature/home/model/product_model.dart';
import '../../../feature/home/view/home_view.dart';
import '../../../feature/product_detail/view/product_detail_view.dart';

class Routes {
  static const String home = '/home';
  static const String productDetail = '/product-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildPageRoute(const HomeView(), settings);

      case productDetail:
        final product = settings.arguments as Product;
        return _buildPageRoute(ProductDetailView(product: product), settings);

      default:
        return _buildPageRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return FadeTransition(
          opacity: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}