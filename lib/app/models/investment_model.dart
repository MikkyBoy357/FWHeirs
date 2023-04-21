class InvestmentModel {
  String? id;
  String? userId;
  String? planId;
  String? brokerId;
  String? duration;
  String? vestedAmount;
  String? isActive;
  String? status;
  String? isClosed;
  String? expectedReturn;
  String? mt4Account;
  String? mt4Server;
  String? fwhServer;
  String? defaultPassword;
  String? promReturm;
  String? revenueSplit;
  String? deposits;
  String? withdrawal;
  String? volume;
  String? profit;
  String? balance;
  String? monitor;
  String? vestedDate;
  String? createdAt;
  String? updatedAt;
  String? broker;
  String? package;
  String? currentEquity;
  int? profitPercentage;
  int? totalBalance;

  InvestmentModel(
      {this.id,
      this.userId,
      this.planId,
      this.brokerId,
      this.duration,
      this.vestedAmount,
      this.isActive,
      this.status,
      this.isClosed,
      this.expectedReturn,
      this.mt4Account,
      this.mt4Server,
      this.fwhServer,
      this.defaultPassword,
      this.promReturm,
      this.revenueSplit,
      this.deposits,
      this.withdrawal,
      this.volume,
      this.profit,
      this.balance,
      this.monitor,
      this.vestedDate,
      this.createdAt,
      this.updatedAt,
      this.broker,
      this.package,
      this.currentEquity,
      this.profitPercentage,
      this.totalBalance});

  InvestmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    brokerId = json['broker_id'];
    duration = json['duration'];
    vestedAmount = json['vested_amount'];
    isActive = json['is_active'];
    status = json['status'];
    isClosed = json['is_closed'];
    expectedReturn = json['expected_return'];
    mt4Account = json['mt4_account'];
    mt4Server = json['mt4_server'];
    fwhServer = json['fwh_server'];
    defaultPassword = json['default_password'];
    promReturm = json['prom_returm'];
    revenueSplit = json['revenue_split'];
    deposits = json['deposits'];
    withdrawal = json['withdrawal'];
    volume = json['volume'];
    profit = json['profit'];
    balance = json['balance'];
    monitor = json['monitor'];
    vestedDate = json['vested_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    broker = json['broker'];
    package = json['package'];
    currentEquity = json['current_equity'];
    profitPercentage = json['profit_percentage'];
    totalBalance = json['total_balance'];
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
    data['status'] = this.status;
    data['is_closed'] = this.isClosed;
    data['expected_return'] = this.expectedReturn;
    data['mt4_account'] = this.mt4Account;
    data['mt4_server'] = this.mt4Server;
    data['fwh_server'] = this.fwhServer;
    data['default_password'] = this.defaultPassword;
    data['prom_returm'] = this.promReturm;
    data['revenue_split'] = this.revenueSplit;
    data['deposits'] = this.deposits;
    data['withdrawal'] = this.withdrawal;
    data['volume'] = this.volume;
    data['profit'] = this.profit;
    data['balance'] = this.balance;
    data['monitor'] = this.monitor;
    data['vested_date'] = this.vestedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['broker'] = this.broker;
    data['package'] = this.package;
    data['current_equity'] = this.currentEquity;
    data['profit_percentage'] = this.profitPercentage;
    data['total_balance'] = this.totalBalance;
    return data;
  }
}
