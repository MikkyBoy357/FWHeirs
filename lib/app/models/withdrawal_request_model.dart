/// id : 1
/// userid : "FWH0000001"
/// accountid : 3
/// amount : 1000
/// status : "PENDING"
/// created_at : "2023-04-02 02:42:43"
/// updated_at : "2023-04-02 02:42:43"

class WithdrawalRequestModel {
  WithdrawalRequestModel({
    num? id,
    String? userid,
    num? accountid,
    num? amount,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userid = userid;
    _accountid = accountid;
    _amount = amount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WithdrawalRequestModel.fromJson(dynamic json) {
    _id = json['id'];
    _userid = json['userid'];
    _accountid = json['accountid'];
    _amount = json['amount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _userid;
  num? _accountid;
  num? _amount;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  WithdrawalRequestModel copyWith({
    num? id,
    String? userid,
    num? accountid,
    num? amount,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      WithdrawalRequestModel(
        id: id ?? _id,
        userid: userid ?? _userid,
        accountid: accountid ?? _accountid,
        amount: amount ?? _amount,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get userid => _userid;
  num? get accountid => _accountid;
  num? get amount => _amount;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userid'] = _userid;
    map['accountid'] = _accountid;
    map['amount'] = _amount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
