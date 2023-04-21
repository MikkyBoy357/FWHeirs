class MyProfileModel {
  String? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? refCode;
  String? refBy;
  String? isActive;
  String? isAgent;
  String? createdAt;
  String? updatedAt;

  MyProfileModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.refCode,
      this.refBy,
      this.isActive,
      this.isAgent,
      this.createdAt,
      this.updatedAt});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    refCode = json['ref_code'];
    refBy = json['ref_by'];
    isActive = json['is_active'];
    isAgent = json['is_agent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['ref_code'] = this.refCode;
    data['ref_by'] = this.refBy;
    data['is_active'] = this.isActive;
    data['is_agent'] = this.isAgent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
