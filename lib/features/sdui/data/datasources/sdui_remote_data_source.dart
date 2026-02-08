import 'package:dio/dio.dart';
import '../models/screen_config_model.dart';
import '../../../../core/error/exceptions.dart';

/// Remote data source for SDUI operations
abstract class SduiRemoteDataSource {
  /// Fetches screen configuration from the server
  Future<ScreenConfigModel> getScreenConfig(String screenId);
}

class SduiRemoteDataSourceImpl implements SduiRemoteDataSource {
  final Dio dio;

  SduiRemoteDataSourceImpl({required this.dio});

  @override
  Future<ScreenConfigModel> getScreenConfig(String screenId) async {
    try {
      final response = await dio.get('/screens/$screenId');
      
      if (response.statusCode == 200) {
        return ScreenConfigModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to fetch screen config');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Network timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException(e.message ?? 'Server error');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
