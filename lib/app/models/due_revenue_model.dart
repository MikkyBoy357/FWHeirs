class DueRevenueModel {
  String? dueRevenue;
  String? mintid;
  String? message;

  DueRevenueModel({this.dueRevenue, this.mintid, this.message});

  DueRevenueModel.fromJson(Map<String, dynamic> json) {
    dueRevenue = json['due_revenue'];
    mintid = json['mintid'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['due_revenue'] = this.dueRevenue;
    data['mintid'] = this.mintid;
    data['message'] = this.message;
    return data;
  }
}
