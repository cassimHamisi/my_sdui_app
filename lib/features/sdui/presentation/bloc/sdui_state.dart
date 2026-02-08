part of 'sdui_bloc.dart';

/// Base class for SDUI states
abstract class SduiState extends Equatable {
  const SduiState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SduiInitial extends SduiState {
  const SduiInitial();
}

/// Loading state
class SduiLoading extends SduiState {
  const SduiLoading();
}

/// Success state with screen configuration
class SduiLoaded extends SduiState {
  final ScreenConfig screenConfig;

  const SduiLoaded(this.screenConfig);

  @override
  List<Object?> get props => [screenConfig];
}

/// Error state
class SduiError extends SduiState {
  final String message;

  const SduiError(this.message);

  @override
  List<Object?> get props => [message];
}
