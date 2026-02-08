// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenConfigModel _$ScreenConfigModelFromJson(Map<String, dynamic> json) =>
    ScreenConfigModel(
      id: json['id'] as String,
      title: json['title'] as String,
      components: (json['components'] as List<dynamic>)
          .map((e) => ComponentConfigModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScreenConfigModelToJson(ScreenConfigModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'components': instance.components,
    };

ComponentConfigModel _$ComponentConfigModelFromJson(
        Map<String, dynamic> json) =>
    ComponentConfigModel(
      id: json['id'] as String,
      type: json['type'] as String,
      properties: json['properties'] as Map<String, dynamic>,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => ComponentConfigModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComponentConfigModelToJson(
        ComponentConfigModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'properties': instance.properties,
      'children': instance.children,
    };
