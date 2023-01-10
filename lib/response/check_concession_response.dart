class CheckConcessionResponse {
  CheckConcessionResponse({
      this.code, 
      this.concession, 
      this.msg,});

  CheckConcessionResponse.fromJson(dynamic json) {
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
      this.pgenderresult, 
      this.pageresult, 
      this.sponlineverificationyn, 
      this.spidverificationyn, 
      this.spidverification, 
      this.spdocumentverificationyn, 
      this.spdocumentverification, 
      this.spconcessionname,});

  Concession.fromJson(dynamic json) {
    pgenderresult = json['P_GENDER_RESULT'];
    pageresult = json['P_AGE_RESULT'];
    sponlineverificationyn = json['SP_ONLINEVERIFICATION_YN'];
    spidverificationyn = json['SP_IDVERIFICATION_YN'];
    spidverification = json['SP_IDVERIFICATION'];
    spdocumentverificationyn = json['SP_DOCUMENTVERIFICATION_YN'];
    spdocumentverification = json['SP_DOCUMENTVERIFICATION'];
    spconcessionname = json['SP_CONCESSION_NAME'];
  }
  String? pgenderresult;
  String? pageresult;
  String? sponlineverificationyn;
  String? spidverificationyn;
  dynamic spidverification;
  String? spdocumentverificationyn;
  dynamic spdocumentverification;
  String? spconcessionname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['P_GENDER_RESULT'] = pgenderresult;
    map['P_AGE_RESULT'] = pageresult;
    map['SP_ONLINEVERIFICATION_YN'] = sponlineverificationyn;
    map['SP_IDVERIFICATION_YN'] = spidverificationyn;
    map['SP_IDVERIFICATION'] = spidverification;
    map['SP_DOCUMENTVERIFICATION_YN'] = spdocumentverificationyn;
    map['SP_DOCUMENTVERIFICATION'] = spdocumentverification;
    map['SP_CONCESSION_NAME'] = spconcessionname;
    return map;
  }

}