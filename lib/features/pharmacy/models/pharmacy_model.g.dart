// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyModel _$PharmacyModelFromJson(Map<String, dynamic> json) =>
    PharmacyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      personnel: (json['personnel'] as List<dynamic>)
          .map((e) => PharmacyPerson.fromJson(e as Map<String, dynamic>))
          .toList(),
      shortDesc: json['shortDesc'] as String?,
      longDesc: json['longDesc'] as String?,
      usersIds:
          (json['usersIds'] as List<dynamic>).map((e) => e as String).toList(),
      cover: json['cover'] as String?,
      icon: json['icon'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$PharmacyStatusEnumMap, json['status']) ??
          PharmacyStatus.onCreation,
    );

Map<String, dynamic> _$PharmacyModelToJson(PharmacyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'shortDesc': instance.shortDesc,
      'longDesc': instance.longDesc,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'personnel': instance.personnel.map((e) => e.toJson()).toList(),
      'status': _$PharmacyStatusEnumMap[instance.status]!,
      'location': instance.location?.toJson(),
      'icon': instance.icon,
      'cover': instance.cover,
      'usersIds': instance.usersIds,
    };

const _$PharmacyStatusEnumMap = {
  PharmacyStatus.onCreation: 'onCreation',
  PharmacyStatus.reviewPending: 'reviewPending',
  PharmacyStatus.accepted: 'accepted',
  PharmacyStatus.refused: 'refused',
  PharmacyStatus.stopped: 'stopped',
};

PharmacyPerson _$PharmacyPersonFromJson(Map<String, dynamic> json) =>
    PharmacyPerson(
      userId: json['userId'] as String,
      addedAt: const DateTimeConverter().fromJson(json['addedAt'] as String),
      endAt: _$JsonConverterFromJson<String, DateTime>(
          json['endAt'], const DateTimeConverter().fromJson),
      role: $enumDecode(_$PharmacyRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$PharmacyPersonToJson(PharmacyPerson instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'addedAt': const DateTimeConverter().toJson(instance.addedAt),
      'endAt': _$JsonConverterToJson<String, DateTime>(
          instance.endAt, const DateTimeConverter().toJson),
      'role': _$PharmacyRoleEnumMap[instance.role]!,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$PharmacyRoleEnumMap = {
  PharmacyRole.owner: 'owner',
  PharmacyRole.admin: 'admin',
  PharmacyRole.moderator: 'moderator',
  PharmacyRole.worker: 'worker',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
