import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/init/injection.dart';
import 'core/util/routing/app_route.dart';
import 'feature/home/view/home_view.dart';
import 'feature/home/view_model/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      // Get HomeViewModel instance from dependency injection
      create: (_) => getIt<HomeViewModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nexivion PoC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2563EB),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        ),
        onGenerateRoute: Routes.generateRoute,
        home: const HomeView(),
      ),
    );
  }
}
