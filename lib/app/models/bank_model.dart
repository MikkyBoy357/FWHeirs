/// name : "9 PAYMENT SOLUTIONS BANK"
/// code : "120001"
/// ussdTemplate : null
/// baseUssdCode : null
/// transferUssdTemplate : null

class BankModel {
  BankModel({
    String? name,
    String? code,
    dynamic ussdTemplate,
    dynamic baseUssdCode,
    dynamic transferUssdTemplate,
  }) {
    _name = name;
    _code = code;
    _ussdTemplate = ussdTemplate;
    _baseUssdCode = baseUssdCode;
    _transferUssdTemplate = transferUssdTemplate;
  }

  BankModel.fromJson(dynamic json) {
    _name = json['name'];
    _code = json['code'];
    _ussdTemplate = json['ussdTemplate'];
    _baseUssdCode = json['baseUssdCode'];
    _transferUssdTemplate = json['transferUssdTemplate'];
  }

  String? _name;
  String? _code;
  dynamic _ussdTemplate;
  dynamic _baseUssdCode;
  dynamic _transferUssdTemplate;

  BankModel copyWith({
    String? name,
    String? code,
    dynamic ussdTemplate,
    dynamic baseUssdCode,
    dynamic transferUssdTemplate,
  }) =>
      BankModel(
        name: name ?? _name,
        code: code ?? _code,
        ussdTemplate: ussdTemplate ?? _ussdTemplate,
        baseUssdCode: baseUssdCode ?? _baseUssdCode,
        transferUssdTemplate: transferUssdTemplate ?? _transferUssdTemplate,
      );

  String? get name => _name;

  String? get code => _code;

  dynamic get ussdTemplate => _ussdTemplate;

  dynamic get baseUssdCode => _baseUssdCode;

  dynamic get transferUssdTemplate => _transferUssdTemplate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['code'] = _code;
    map['ussdTemplate'] = _ussdTemplate;
    map['baseUssdCode'] = _baseUssdCode;
    map['transferUssdTemplate'] = _transferUssdTemplate;
    return map;
  }
}
