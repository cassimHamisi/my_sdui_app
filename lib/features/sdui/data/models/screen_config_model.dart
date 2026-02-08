import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/screen_config.dart';

part 'screen_config_model.g.dart';

@JsonSerializable()
class ScreenConfigModel extends ScreenConfig {
  const ScreenConfigModel({
    required super.id,
    required super.title,
    required super.components,
  });

  factory ScreenConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ScreenConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenConfigModelToJson(this);

  factory ScreenConfigModel.fromEntity(ScreenConfig entity) {
    return ScreenConfigModel(
      id: entity.id,
      title: entity.title,
      components: entity.components
          .map((c) => ComponentConfigModel.fromEntity(c))
          .toList(),
    );
  }
}

@JsonSerializable()
class ComponentConfigModel extends ComponentConfig {
  const ComponentConfigModel({
    required super.id,
    required super.type,
    required super.properties,
    super.children,
  });

  factory ComponentConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ComponentConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentConfigModelToJson(this);

  factory ComponentConfigModel.fromEntity(ComponentConfig entity) {
    return ComponentConfigModel(
      id: entity.id,
      type: entity.type,
      properties: entity.properties,
      children: entity.children
          ?.map((c) => ComponentConfigModel.fromEntity(c))
          .toList(),
    );
  }
}
