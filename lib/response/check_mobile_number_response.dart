class CheckMobileNumberResponse {
  CheckMobileNumberResponse({
      this.code, 
      this.traveller, 
      this.msg,});

  CheckMobileNumberResponse.fromJson(dynamic json) {
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
      this.mobilenumber, 
      this.username, 
      this.alreadyYn, 
      this.encryptOTP,});

  Traveller.fromJson(dynamic json) {
    mobilenumber = json['MOBILENUMBER'];
    username = json['USERNAME'];
    alreadyYn = json['ALREADYYN'];
    encryptOTP = json['EncryptOTP'];
  }
  String? mobilenumber;
  String? username;
  String? alreadyYn;
  String? encryptOTP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MOBILENUMBER'] = mobilenumber;
    map['USERNAME'] = username;
    map['ALREADYYN'] = alreadyYn;
    map['EncryptOTP'] = encryptOTP;
    return map;
  }

}