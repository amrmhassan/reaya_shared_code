// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyRequestModel _$PharmacyRequestModelFromJson(
        Map<String, dynamic> json) =>
    PharmacyRequestModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      notes: json['notes'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      userId: json['userId'] as String,
      pharmacyId: json['pharmacyId'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      state: PharmacyRequestModelState.fromJson(
          json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PharmacyRequestModelToJson(
        PharmacyRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'email': instance.email,
      'notes': instance.notes,
      'images': instance.images,
      'userId': instance.userId,
      'pharmacyId': instance.pharmacyId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'state': instance.state.toJson(),
    };

PharmacyRequestModelState _$PharmacyRequestModelStateFromJson(
        Map<String, dynamic> json) =>
    PharmacyRequestModelState(
      state: $enumDecode(_$RequestModelStateEnumMap, json['state']),
      statedAt: const DateTimeConverter().fromJson(json['statedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PharmacyRequestModelStateToJson(
        PharmacyRequestModelState instance) =>
    <String, dynamic>{
      'state': _$RequestModelStateEnumMap[instance.state]!,
      'statedAt': const DateTimeConverter().toJson(instance.statedAt),
      'notes': instance.notes,
    };

const _$RequestModelStateEnumMap = {
  RequestModelState.pending: 'pending',
  RequestModelState.delivered: 'delivered',
  RequestModelState.returned: 'returned',
  RequestModelState.refused: 'refused',
};
