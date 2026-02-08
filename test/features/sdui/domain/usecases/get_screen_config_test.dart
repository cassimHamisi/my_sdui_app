import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sdui_app/core/error/failures.dart';
import 'package:sdui_app/features/sdui/domain/entities/screen_config.dart';
import 'package:sdui_app/features/sdui/domain/repositories/sdui_repository.dart';
import 'package:sdui_app/features/sdui/domain/usecases/get_screen_config.dart';

import 'get_screen_config_test.mocks.dart';

@GenerateMocks([SduiRepository])
void main() {
  late GetScreenConfig usecase;
  late MockSduiRepository mockRepository;

  setUp(() {
    mockRepository = MockSduiRepository();
    usecase = GetScreenConfig(mockRepository);
  });

  const tScreenId = 'home';
  const tScreenConfig = ScreenConfig(
    id: 'home',
    title: 'Home Screen',
    components: [],
  );

  test('should get screen config from the repository', () async {
    // arrange
    when(mockRepository.getScreenConfig(any))
        .thenAnswer((_) async => const Right(tScreenConfig));

    // act
    final result = await usecase(const Params(screenId: tScreenId));

    // assert
    expect(result, const Right(tScreenConfig));
    verify(mockRepository.getScreenConfig(tScreenId));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository call fails', () async {
    // arrange
    const tFailure = ServerFailure('Server error');
    when(mockRepository.getScreenConfig(any))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(const Params(screenId: tScreenId));

    // assert
    expect(result, const Left(tFailure));
    verify(mockRepository.getScreenConfig(tScreenId));
    verifyNoMoreInteractions(mockRepository);
  });
}
