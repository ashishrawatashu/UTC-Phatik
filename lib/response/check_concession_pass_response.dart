class CheckConcessionPassResponse {
  CheckConcessionPassResponse({
      this.code, 
      this.concession, 
      this.msg,});

  CheckConcessionPassResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Concession'] != null) {
      concession = [];
      json['Concession'].forEach((v) {
        concession?.add(Concession.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Concession>? concession;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (concession != null) {
      map['Concession'] = concession?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Concession {
  Concession({
      this.presult,});

  Concession.fromJson(dynamic json) {
    presult = json['P_RESULT'];
  }
  String? presult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['P_RESULT'] = presult;
    return map;
  }

}