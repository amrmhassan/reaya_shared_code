import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code/shared_code/models/offer_model.dart';

part 'pharmacy_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class PharmacyRequestModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String notes;
  final List<String> images;
  final String userId;
  final String pharmacyId;
  final DateTime createdAt;
  final PharmacyRequestModelState state;

  const PharmacyRequestModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.notes,
    required this.images,
    required this.userId,
    required this.pharmacyId,
    required this.createdAt,
    required this.state,
  });

  factory PharmacyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class PharmacyRequestModelState {
  final RequestModelState state;
  final DateTime statedAt;
  final String? notes;
  const PharmacyRequestModelState({
    required this.state,
    required this.statedAt,
    this.notes,
  });
  factory PharmacyRequestModelState.fromJson(Map<String, dynamic> json) =>
      _$PharmacyRequestModelStateFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyRequestModelStateToJson(this);
}

enum RequestModelState {
  @JsonValue('pending')
  pending,
  @JsonValue('delivered')
  delivered,
  @JsonValue('returned')
  returned,
  @JsonValue('refused')
  refused,
}
