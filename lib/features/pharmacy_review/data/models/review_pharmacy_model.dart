import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code/shared_code/models/offer_model.dart';
part 'review_pharmacy_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class ReviewPharmacyModel {
  final String pharmacyId;
  final DateTime sentAt;

  const ReviewPharmacyModel({
    required this.pharmacyId,
    required this.sentAt,
  });

  factory ReviewPharmacyModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewPharmacyModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewPharmacyModelToJson(this);
}
