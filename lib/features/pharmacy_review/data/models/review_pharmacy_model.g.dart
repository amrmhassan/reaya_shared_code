// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_pharmacy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewPharmacyModel _$ReviewPharmacyModelFromJson(Map<String, dynamic> json) =>
    ReviewPharmacyModel(
      pharmacyId: json['pharmacyId'] as String,
      sentAt: const DateTimeConverter().fromJson(json['sentAt'] as String),
    );

Map<String, dynamic> _$ReviewPharmacyModelToJson(
        ReviewPharmacyModel instance) =>
    <String, dynamic>{
      'pharmacyId': instance.pharmacyId,
      'sentAt': const DateTimeConverter().toJson(instance.sentAt),
    };
