class PayoutAccountModel {
  String? id;
  String? userId;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? bankCode;
  String? createdAt;
  String? updatedAt;

  PayoutAccountModel(
      {this.id,
      this.userId,
      this.bankName,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.createdAt,
      this.updatedAt});

  PayoutAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankCode = json['bank_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['bank_code'] = this.bankCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
