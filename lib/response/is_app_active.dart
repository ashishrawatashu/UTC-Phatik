class IsAppActive {

  IsAppActive({this.code, this.result, this.helpdek, this.msg,});
  IsAppActive.fromJson(dynamic json) {
    code = json['code'];
    if (json['Result'] != null) {
      result = [];
      json['Result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    if (json['Helpdek'] != null) {
      helpdek = [];
      json['Helpdek'].forEach((v) {
        helpdek?.add(Helpdek.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Result>? result;
  List<Helpdek>? helpdek;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (result != null) {
      map['Result'] = result?.map((v) => v.toJson()).toList();
    }
    if (helpdek != null) {
      map['Helpdek'] = helpdek?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Helpdek {
  Helpdek({
      this.mobileNo, 
      this.emailId,});

  Helpdek.fromJson(dynamic json) {
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
  }
  String? mobileNo;
  String? emailId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileNo'] = mobileNo;
    map['emailId'] = emailId;
    return map;
  }

}

class Result {
  Result({
      this.id, 
      this.app, 
      this.description, 
      this.updatedate, 
      this.active, 
      this.version,});

  Result.fromJson(dynamic json) {
    id = json['ID'];
    app = json['APP'];
    description = json['DESCRIPTION'];
    updatedate = json['UPDATEDATE'];
    active = json['ACTIVE'];
    version = json['VERSION'];
  }

  int? id;
  String? app;
  String? description;
  String? updatedate;
  String? active;
  String? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['APP'] = app;
    map['DESCRIPTION'] = description;
    map['UPDATEDATE'] = updatedate;
    map['ACTIVE'] = active;
    map['VERSION'] = version;
    return map;
  }

}