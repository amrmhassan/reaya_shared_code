import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code/shared_code/models/offer_model.dart';

part 'pharmacy_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class PharmacyModel {
  final String id;
  final String name;
  final String address;
  final DateTime createdAt;
  final List<PharmacyPerson> personnel;

  const PharmacyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.createdAt,
    required this.personnel,
  });
  factory PharmacyModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyModelFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class PharmacyPerson {
  final String userId;
  final DateTime addedAt;
  final DateTime? endAt;
  final PharmacyRole role;

  const PharmacyPerson({
    required this.userId,
    required this.addedAt,
    required this.endAt,
    required this.role,
  });
  factory PharmacyPerson.fromJson(Map<String, dynamic> json) =>
      _$PharmacyPersonFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyPersonToJson(this);
}

enum PharmacyRole {
  @JsonValue('owner')
  owner,
  @JsonValue('admin')
  admin,
  @JsonValue('moderator')
  moderator,
  @JsonValue('worker')
  worker,
}