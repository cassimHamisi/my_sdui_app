import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/screen_config.dart';
import '../repositories/sdui_repository.dart';

/// Use case for fetching screen configuration
class GetScreenConfig implements UseCase<ScreenConfig, Params> {
  final SduiRepository repository;

  GetScreenConfig(this.repository);

  @override
  Future<Either<Failure, ScreenConfig>> call(Params params) async {
    return await repository.getScreenConfig(params.screenId);
  }
}

class Params extends Equatable {
  final String screenId;

  const Params({required this.screenId});

  @override
  List<Object?> get props => [screenId];
}
