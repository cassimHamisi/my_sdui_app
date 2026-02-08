import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/screen_config.dart';

/// Repository interface for SDUI operations
abstract class SduiRepository {
  /// Fetches screen configuration from the server
  Future<Either<Failure, ScreenConfig>> getScreenConfig(String screenId);
}
