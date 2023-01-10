class SaveGrievanceResponse {
  SaveGrievanceResponse({
      this.code, 
      this.grievance, 
      this.msg,});

  SaveGrievanceResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Grievance'] != null) {
      grievance = [];
      json['Grievance'].forEach((v) {
        grievance?.add(Grievance.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Grievance>? grievance;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (grievance != null) {
      map['Grievance'] = grievance?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Grievance {
  Grievance({
      this.result,});

  Grievance.fromJson(dynamic json) {
    result = json['RESULT'];
  }
  String? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RESULT'] = result;
    return map;
  }

}