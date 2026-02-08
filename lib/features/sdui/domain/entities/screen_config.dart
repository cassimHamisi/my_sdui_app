import 'package:equatable/equatable.dart';

/// Represents a screen configuration from the server
class ScreenConfig extends Equatable {
  final String id;
  final String title;
  final List<ComponentConfig> components;

  const ScreenConfig({
    required this.id,
    required this.title,
    required this.components,
  });

  @override
  List<Object?> get props => [id, title, components];
}

/// Represents a UI component configuration
class ComponentConfig extends Equatable {
  final String id;
  final String type;
  final Map<String, dynamic> properties;
  final List<ComponentConfig>? children;

  const ComponentConfig({
    required this.id,
    required this.type,
    required this.properties,
    this.children,
  });

  @override
  List<Object?> get props => [id, type, properties, children];
}
