class BrokerModel {
  String? id;
  String? name;
  String? iosLink;
  String? androidLink;
  String? webLink;
  String? logo;
  String? tradingPassword;
  String? nickname;
  String? fullname;
  String? maxVest;
  String? descr1;
  String? descr2;
  String? descr3;
  String? createdAt;
  String? updatedAt;

  BrokerModel(
      {this.id,
      this.name,
      this.iosLink,
      this.androidLink,
      this.webLink,
      this.logo,
      this.tradingPassword,
      this.nickname,
      this.fullname,
      this.maxVest,
      this.descr1,
      this.descr2,
      this.descr3,
      this.createdAt,
      this.updatedAt});

  BrokerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iosLink = json['ios_link'];
    androidLink = json['android_link'];
    webLink = json['web_link'];
    logo = json['logo'];
    tradingPassword = json['trading_password'];
    nickname = json['nickname'];
    fullname = json['fullname'];
    maxVest = json['max_vest'];
    descr1 = json['descr1'];
    descr2 = json['descr2'];
    descr3 = json['descr3'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ios_link'] = this.iosLink;
    data['android_link'] = this.androidLink;
    data['web_link'] = this.webLink;
    data['logo'] = this.logo;
    data['trading_password'] = this.tradingPassword;
    data['nickname'] = this.nickname;
    data['fullname'] = this.fullname;
    data['max_vest'] = this.maxVest;
    data['descr1'] = this.descr1;
    data['descr2'] = this.descr2;
    data['descr3'] = this.descr3;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
