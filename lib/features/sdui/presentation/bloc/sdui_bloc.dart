import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/screen_config.dart';
import '../../domain/usecases/get_screen_config.dart';

part 'sdui_event.dart';
part 'sdui_state.dart';

/// BLoC for managing SDUI screen state
class SduiBloc extends Bloc<SduiEvent, SduiState> {
  final GetScreenConfig getScreenConfig;

  SduiBloc({required this.getScreenConfig}) : super(const SduiInitial()) {
    on<LoadScreenConfig>(_onLoadScreenConfig);
    on<RefreshScreen>(_onRefreshScreen);
  }

  String? _currentScreenId;

  Future<void> _onLoadScreenConfig(
    LoadScreenConfig event,
    Emitter<SduiState> emit,
  ) async {
    _currentScreenId = event.screenId;
    emit(const SduiLoading());

    final result = await getScreenConfig(Params(screenId: event.screenId));

    result.fold(
      (failure) => emit(SduiError(failure.message)),
      (screenConfig) => emit(SduiLoaded(screenConfig)),
    );
  }

  Future<void> _onRefreshScreen(
    RefreshScreen event,
    Emitter<SduiState> emit,
  ) async {
    if (_currentScreenId != null) {
      add(LoadScreenConfig(_currentScreenId!));
    }
  }
}
