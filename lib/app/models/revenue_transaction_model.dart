class RevenueTransactionModel {
  String? id;
  String? userid;
  String? mintid;
  String? amount;
  String? proof;
  String? status;
  String? createdAt;
  String? updatedAt;

  RevenueTransactionModel(
      {this.id,
      this.userid,
      this.mintid,
      this.amount,
      this.proof,
      this.status,
      this.createdAt,
      this.updatedAt});

  RevenueTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    mintid = json['mintid'];
    amount = json['amount'];
    proof = json['proof'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['mintid'] = this.mintid;
    data['amount'] = this.amount;
    data['proof'] = this.proof;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
