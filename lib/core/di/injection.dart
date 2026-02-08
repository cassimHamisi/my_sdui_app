import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/sdui/data/datasources/sdui_remote_data_source.dart';
import '../../features/sdui/data/repositories/sdui_repository_impl.dart';
import '../../features/sdui/domain/repositories/sdui_repository.dart';
import '../../features/sdui/domain/usecases/get_screen_config.dart';
import '../../features/sdui/presentation/bloc/sdui_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - SDUI
  // Bloc
  sl.registerFactory(
    () => SduiBloc(getScreenConfig: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetScreenConfig(sl()));

  // Repository
  sl.registerLazySingleton<SduiRepository>(
    () => SduiRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SduiRemoteDataSource>(
    () => SduiRemoteDataSourceImpl(dio: sl()),
  );

  // Core
  sl.registerLazySingleton(() => Dio(
        BaseOptions(
          baseUrl: 'https://api.example.com', // Replace with your API URL
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ),
      ));
}
