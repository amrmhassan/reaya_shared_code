// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String? ?? 'No Name',
      address: json['address'] as String,
      type: json['type'] as String,
      signedUpAt:
          const DateTimeConverter().fromJson(json['signedUpAt'] as String),
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'address': instance.address,
      'type': instance.type,
      'signedUpAt': const DateTimeConverter().toJson(instance.signedUpAt),
      'phone': instance.phone,
    };
