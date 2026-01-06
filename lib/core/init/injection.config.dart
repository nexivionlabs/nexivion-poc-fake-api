// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:poc_project_fake_api/core/service/network_checker.dart'
    as _i309;
import 'package:poc_project_fake_api/core/util/network/base_api.dart' as _i497;
import 'package:poc_project_fake_api/feature/home/service/product_service.dart'
    as _i405;
import 'package:poc_project_fake_api/feature/home/view_model/home_view_model.dart'
    as _i763;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i309.NetworkChecker>(() => _i309.NetworkChecker());
    gh.lazySingleton<_i497.ApiBase>(() => _i497.ApiBase());
    gh.lazySingleton<_i405.ProductService>(
      () => _i405.ProductService(gh<_i497.ApiBase>()),
    );
    gh.factory<_i763.HomeViewModel>(
      () => _i763.HomeViewModel(
        gh<_i405.ProductService>(),
        gh<_i309.NetworkChecker>(),
      ),
    );
    return this;
  }
}
