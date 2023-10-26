import 'package:json_annotation/json_annotation.dart';
import 'package:reaya_shared_code/features/ads/data/constants/ads_constats.dart';
import 'package:shared_code/shared_code/models/offer_model.dart';
part 'ad_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class AdModel {
  final String id;
  final String imageUrl;
  final bool active;
  final DateTime createdAt;
  final DateTime? endAt;
  @JsonValue(AdsConstants.defaultActiveSeconds)
  final int activeSeconds;
  final String? targetLink;

  const AdModel({
    required this.id,
    required this.imageUrl,
    this.active = true,
    required this.createdAt,
    required this.endAt,
    this.activeSeconds = AdsConstants.defaultActiveSeconds,
    this.targetLink,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) =>
      _$AdModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdModelToJson(this);

  bool get view {
    if (!active) return false;
    if (endAt == null) return true;
    bool ended = endAt!.isBefore(DateTime.now());
    return ended;
  }
}
