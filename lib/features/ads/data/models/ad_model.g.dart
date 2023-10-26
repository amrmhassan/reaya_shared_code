// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdModel _$AdModelFromJson(Map<String, dynamic> json) => AdModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      active: json['active'] as bool? ?? true,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      endAt: _$JsonConverterFromJson<String, DateTime>(
          json['endAt'], const DateTimeConverter().fromJson),
      activeSeconds:
          json['activeSeconds'] as int? ?? AdsConstants.defaultActiveSeconds,
      targetLink: json['targetLink'] as String?,
    );

Map<String, dynamic> _$AdModelToJson(AdModel instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'active': instance.active,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'endAt': _$JsonConverterToJson<String, DateTime>(
          instance.endAt, const DateTimeConverter().toJson),
      'activeSeconds': instance.activeSeconds,
      'targetLink': instance.targetLink,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
