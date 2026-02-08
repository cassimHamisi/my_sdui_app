part of 'sdui_bloc.dart';

/// Base class for SDUI events
abstract class SduiEvent extends Equatable {
  const SduiEvent();

  @override
  List<Object> get props => [];
}

/// Event to load a screen configuration
class LoadScreenConfig extends SduiEvent {
  final String screenId;

  const LoadScreenConfig(this.screenId);

  @override
  List<Object> get props => [screenId];
}

/// Event to refresh the current screen
class RefreshScreen extends SduiEvent {
  const RefreshScreen();
}
