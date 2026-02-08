import 'package:dio/dio.dart';
import '../models/screen_config_model.dart';
import '../../../../core/error/exceptions.dart';
import 'mock_sdui_data.dart';

/// Remote data source for SDUI operations
abstract class SduiRemoteDataSource {
  /// Fetches screen configuration from the server
  Future<ScreenConfigModel> getScreenConfig(String screenId);
}

class SduiRemoteDataSourceImpl implements SduiRemoteDataSource {
  final Dio dio;
  final bool useMockData;

  SduiRemoteDataSourceImpl({
    required this.dio,
    this.useMockData = true, // Set to false when you have a real API
  });

  @override
  Future<ScreenConfigModel> getScreenConfig(String screenId) async {
    // Use mock data for development/testing
    if (useMockData) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final mockData = MockSduiData.getMockScreen(screenId);
      if (mockData != null) {
        return mockData;
      }
      throw ServerException('Screen not found: $screenId');
    }

    // Real API implementation
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
