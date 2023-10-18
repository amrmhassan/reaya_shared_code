import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code/shared_code/models/offer_model.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class UserModel {
  final String id;
  final String email;
  @JsonValue('No Name')
  final String fullName;
  final String address;
  final String type;
  final DateTime signedUpAt;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    this.fullName = 'No Name',
    required this.address,
    required this.type,
    required this.signedUpAt,
    required this.phone,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum UserType {
  pharmacist,
  user,
  doctor,
}
