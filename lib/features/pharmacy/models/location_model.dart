import 'package:json_annotation/json_annotation.dart';
part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationModel {
  final double lat;
  final double lng;

  const LocationModel(this.lat, this.lng);

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
