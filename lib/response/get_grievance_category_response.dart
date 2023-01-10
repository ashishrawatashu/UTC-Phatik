class GetGrievanceCategoryResponse {
  GetGrievanceCategoryResponse({
      this.code, 
      this.result, 
      this.msg,});

  GetGrievanceCategoryResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Grievance'] != null) {
      result = [];
      json['Grievance'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Result>? result;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (result != null) {
      map['Grievance'] = result?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Result {
  Result({
      this.subcatid, 
      this.subcatname, 
      this.catid, 
      this.catname,});

  Result.fromJson(dynamic json) {
    subcatid = json['SUBCATEGORYID'];
    subcatname = json['SUBCATEGORYNAME'];
    catid = json['CATEGORYID'];
    catname = json['CATEGORYNAME'];
  }
  int? subcatid;
  String? subcatname;
  int? catid;
  String? catname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SUBCATEGORYID'] = subcatid;
    map['SUBCATEGORYNAME'] = subcatname;
    map['CATEGORYID'] = catid;
    map['CATEGORYNAME'] = catname;
    return map;
  }

}