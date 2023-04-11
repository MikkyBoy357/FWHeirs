/// id : "FWH0000003"
/// firstname : "John"
/// lastname : "Doe"
/// phone : "08012345675"
/// email : "example1@gmail.com"
/// ref_by : "FWH0000001"
/// password : "123456"
/// is_active : "0"
/// token : "0"
/// created_at : "2023-03-22 09:32:34"
/// updated_at : "2023-03-22 09:32:34"

class ReferralModel {
  ReferralModel({
    String? id,
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
    String? refBy,
    String? password,
    String? isActive,
    String? token,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _phone = phone;
    _email = email;
    _refBy = refBy;
    _password = password;
    _isActive = isActive;
    _token = token;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ReferralModel.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _phone = json['phone'];
    _email = json['email'];
    _refBy = json['ref_by'];
    _password = json['password'];
    _isActive = json['is_active'];
    _token = json['token'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _firstname;
  String? _lastname;
  String? _phone;
  String? _email;
  String? _refBy;
  String? _password;
  String? _isActive;
  String? _token;
  String? _createdAt;
  String? _updatedAt;
  ReferralModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
    String? refBy,
    String? password,
    String? isActive,
    String? token,
    String? createdAt,
    String? updatedAt,
  }) =>
      ReferralModel(
        id: id ?? _id,
        firstname: firstname ?? _firstname,
        lastname: lastname ?? _lastname,
        phone: phone ?? _phone,
        email: email ?? _email,
        refBy: refBy ?? _refBy,
        password: password ?? _password,
        isActive: isActive ?? _isActive,
        token: token ?? _token,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get phone => _phone;
  String? get email => _email;
  String? get refBy => _refBy;
  String? get password => _password;
  String? get isActive => _isActive;
  String? get token => _token;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['phone'] = _phone;
    map['email'] = _email;
    map['ref_by'] = _refBy;
    map['password'] = _password;
    map['is_active'] = _isActive;
    map['token'] = _token;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
