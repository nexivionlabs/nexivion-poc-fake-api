import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Initialize dependency injection
/// This should be called before runApp in main.dart
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
