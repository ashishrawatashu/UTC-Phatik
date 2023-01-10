class GetConcessionTypesResponse {
  GetConcessionTypesResponse({
      this.code, 
      this.concession, 
      this.msg,});

  GetConcessionTypesResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Concession'] != null) {
      concession = [];
      json['Concession'].forEach((v) {
        concession?.add(ConcessionList.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<ConcessionList>? concession;
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

class ConcessionList {
  ConcessionList({
      this.categorycode, 
      this.categoryname,});

  ConcessionList.fromJson(dynamic json) {
    categorycode = json['CATEGORYCODE'];
    categoryname = json['CATEGORYNAME'];
  }
  int? categorycode;
  String? categoryname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CATEGORYCODE'] = categorycode;
    map['CATEGORYNAME'] = categoryname;
    return map;
  }

}