class LoginResponse {
  LoginResponse({
      this.code, 
      this.traveller, 
      this.msg,});

  LoginResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Traveller'] != null) {
      traveller = [];
      json['Traveller'].forEach((v) {
        traveller?.add(Traveller.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Traveller>? traveller;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (traveller != null) {
      map['Traveller'] = traveller?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Traveller {
  Traveller({
      this.mobilenumber,});

  Traveller.fromJson(dynamic json) {
    mobilenumber = json['MOBILENUMBER'];
    username = json['USERNAME'];
  }
  String? mobilenumber;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MOBILENUMBER'] = mobilenumber;
    map['USERNAME'] = username;
    return map;
  }

}