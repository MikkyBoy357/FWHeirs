class InvestmentModel {
  String? id;
  String? userId;
  String? planId;
  String? brokerId;
  String? duration;
  String? vestedAmount;
  String? isActive;
  String? isClosed;
  String? createdAt;
  String? updatedAt;
  String? broker;
  String? package;

  InvestmentModel({
    this.id,
    this.userId,
    this.planId,
    this.brokerId,
    this.duration,
    this.vestedAmount,
    this.isActive,
    this.isClosed,
    this.createdAt,
    this.updatedAt,
    this.broker,
    this.package,
  });

  InvestmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    brokerId = json['broker_id'];
    duration = json['duration'];
    vestedAmount = json['vested_amount'];
    isActive = json['is_active'];
    isClosed = json['is_closed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    broker = json['broker'];
    package = json['package'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plan_id'] = this.planId;
    data['broker_id'] = this.brokerId;
    data['duration'] = this.duration;
    data['vested_amount'] = this.vestedAmount;
    data['is_active'] = this.isActive;
    data['is_closed'] = this.isClosed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['broker'] = this.broker;
    data['package'] = this.package;
    return data;
  }
}
