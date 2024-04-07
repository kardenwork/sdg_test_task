import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:sdg_test_task/src/core/api/api_config.dart';
import 'package:sdg_test_task/src/features/location_pick/data/data_sources/location_pick_local_data_source.dart';
import 'package:sdg_test_task/src/features/location_pick/data/data_sources/location_pick_remote_data_source.dart';
import 'package:sdg_test_task/src/features/location_pick/data/repositories/location_pick_repository_impl.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/repositories/location_pick_repository.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/get_countries_use_case.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/get_country_states_use_case.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/submit_location_use_case.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_pick/country_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_state_pick/country_state_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/location_pick/location_pick_bloc.dart';

class AppDi {
  AppDi._();

  factory AppDi() => _instance;

  static final AppDi _instance = AppDi._();

  final _getIt = GetIt.asNewInstance();

  bool _isInitialized = false;

  Future<GetIt> initialize() async {
    if (_isInitialized) return _getIt;

    final getIt = GetIt.asNewInstance();

    getIt

      // Data
      //
      ..registerSingleton<Dio>(_createDioInstance())
      ..registerFactory<LocationPickRemoteDataSource>(
        () => ApiLocationPickRemoteDataSourceImpl(dio: getIt<Dio>()),
      )
      ..registerFactory<LocationPickLocalDataSource>(
        () => RamLocationPickLocalDataSourceImpl(),
      )
      ..registerFactory<LocationPickRepository>(
        () => LocationPickRepositoryImpl(
          remoteDataSource: getIt<LocationPickRemoteDataSource>(),
          localDataSource: getIt<LocationPickLocalDataSource>(),
        ),
      )

      // Domain
      //
      ..registerFactory<GetCountriesUseCase>(
        () => GetCountriesUseCaseImpl(
          repository: getIt<LocationPickRepository>(),
        ),
      )
      ..registerFactory<GetCountryStatesUseCase>(
        () => GetCountryStatesUseCaseImpl(
          repository: getIt<LocationPickRepository>(),
        ),
      )
      ..registerFactory<SubmitLocationUseCase>(
        () => SubmitLocationUseCaseImpl(
          repository: getIt<LocationPickRepository>(),
        ),
      )

      // Presentation
      //
      ..registerFactory<CountryPickBloc>(
        () => CountryPickBlocImpl(
          getCountriesUseCase: getIt<GetCountriesUseCase>(),
        ),
      )
      ..registerFactory<CountryStatePickBloc>(
        () => CountryStatePickBlocImpl(
          getCountryStatesUseCase: getIt<GetCountryStatesUseCase>(),
        ),
      )
      ..registerFactory<LocationPickBloc>(
        () => LocationPickBlocImpl(
          submitLocationUseCase: getIt<SubmitLocationUseCase>(),
        ),
      );

    await getIt.allReady();
    _isInitialized = true;

    return getIt;
  }

  Dio _createDioInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl.toString(),
        headers: ApiConfig.headers,
      ),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }
}
