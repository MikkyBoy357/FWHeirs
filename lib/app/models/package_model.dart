class PackageModel {
  String? id;
  String? name;
  String? minVest;
  String? maxVest;
  String? refPercentage;
  String? createdAt;
  String? updatedAt;

  PackageModel(
      {this.id,
      this.name,
      this.minVest,
      this.maxVest,
      this.refPercentage,
      this.createdAt,
      this.updatedAt});

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minVest = json['min_vest'];
    maxVest = json['max_vest'];
    refPercentage = json['ref_percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_vest'] = this.minVest;
    data['max_vest'] = this.maxVest;
    data['ref_percentage'] = this.refPercentage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
