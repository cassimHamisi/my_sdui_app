import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/screen_config.dart';
import '../../domain/repositories/sdui_repository.dart';
import '../datasources/sdui_remote_data_source.dart';

/// Implementation of the SDUI repository
class SduiRepositoryImpl implements SduiRepository {
  final SduiRemoteDataSource remoteDataSource;

  SduiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ScreenConfig>> getScreenConfig(String screenId) async {
    try {
      final remoteConfig = await remoteDataSource.getScreenConfig(screenId);
      return Right(remoteConfig);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
