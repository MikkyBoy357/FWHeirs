import 'package:hive/hive.dart';

part 'token_model.g.dart';

@HiveType(typeId: 0)
class TokenModel extends HiveObject {
  @HiveField(0)
  String? token;

  TokenModel({
    this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
