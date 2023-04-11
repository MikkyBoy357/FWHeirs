/// id : "3"
/// user_id : "FWH0000001"
/// earning : "0"
/// book_balance : "0"
/// created_at : "2023-03-22 18:32:39"
/// updated_at : "2023-03-22 18:32:39"

class WalletModel {
  WalletModel({
    String? id,
    String? userId,
    String? earning,
    String? bookBalance,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _earning = earning;
    _bookBalance = bookBalance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WalletModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _earning = json['earning'];
    _bookBalance = json['book_balance'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _earning;
  String? _bookBalance;
  String? _createdAt;
  String? _updatedAt;
  WalletModel copyWith({
    String? id,
    String? userId,
    String? earning,
    String? bookBalance,
    String? createdAt,
    String? updatedAt,
  }) =>
      WalletModel(
        id: id ?? _id,
        userId: userId ?? _userId,
        earning: earning ?? _earning,
        bookBalance: bookBalance ?? _bookBalance,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get userId => _userId;
  String? get earning => _earning;
  String? get bookBalance => _bookBalance;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['earning'] = _earning;
    map['book_balance'] = _bookBalance;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
