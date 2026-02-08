import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sdui_app/core/error/failures.dart';
import 'package:sdui_app/features/sdui/domain/entities/screen_config.dart';
import 'package:sdui_app/features/sdui/domain/usecases/get_screen_config.dart';
import 'package:sdui_app/features/sdui/presentation/bloc/sdui_bloc.dart';

import 'sdui_bloc_test.mocks.dart';

@GenerateMocks([GetScreenConfig])
void main() {
  late SduiBloc bloc;
  late MockGetScreenConfig mockGetScreenConfig;

  setUp(() {
    mockGetScreenConfig = MockGetScreenConfig();
    bloc = SduiBloc(getScreenConfig: mockGetScreenConfig);
  });

  tearDown(() {
    bloc.close();
  });

  const tScreenId = 'home';
  const tScreenConfig = ScreenConfig(
    id: 'home',
    title: 'Home Screen',
    components: [],
  );

  test('initial state should be SduiInitial', () {
    expect(bloc.state, const SduiInitial());
  });

  group('LoadScreenConfig', () {
    blocTest<SduiBloc, SduiState>(
      'should emit [SduiLoading, SduiLoaded] when data is fetched successfully',
      build: () {
        when(mockGetScreenConfig(any))
            .thenAnswer((_) async => const Right(tScreenConfig));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadScreenConfig(tScreenId)),
      expect: () => [
        const SduiLoading(),
        const SduiLoaded(tScreenConfig),
      ],
      verify: (_) {
        verify(mockGetScreenConfig(const Params(screenId: tScreenId)));
      },
    );

    blocTest<SduiBloc, SduiState>(
      'should emit [SduiLoading, SduiError] when fetching data fails',
      build: () {
        when(mockGetScreenConfig(any))
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadScreenConfig(tScreenId)),
      expect: () => [
        const SduiLoading(),
        const SduiError('Server error'),
      ],
      verify: (_) {
        verify(mockGetScreenConfig(const Params(screenId: tScreenId)));
      },
    );
  });
}
