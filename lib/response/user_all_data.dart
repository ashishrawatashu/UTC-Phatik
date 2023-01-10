/// phoneNumber : "1234567890"
/// fullName : "_usernameTextEditingController.value.text"
/// isAlreadyRegisterd : true

class User_all_data {
  User_all_data({
      String? phoneNumber, 
      String? fullName, 
      bool? isAlreadyRegisterd,}){
    _phoneNumber = phoneNumber;
    _fullName = fullName;
    _isAlreadyRegisterd = isAlreadyRegisterd;
}

  User_all_data.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
    _fullName = json['fullName'];
    _isAlreadyRegisterd = json['isAlreadyRegisterd'];
  }
  String? _phoneNumber;
  String? _fullName;
  bool? _isAlreadyRegisterd;

  String? get phoneNumber => _phoneNumber;
  String? get fullName => _fullName;
  bool? get isAlreadyRegisterd => _isAlreadyRegisterd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    map['fullName'] = _fullName;
    map['isAlreadyRegisterd'] = _isAlreadyRegisterd;
    return map;
  }

}