class GrievanceCatResponse {
  GrievanceCatResponse({
      this.code, 
      this.result, 
      this.msg,});

  GrievanceCatResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Result'] != null) {
      result = [];
      json['Result'].forEach((v) {
        result?.add(CategoryList.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<CategoryList>? result;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (result != null) {
      map['Result'] = result?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class CategoryList {
  CategoryList({
      this.catid, 
      this.catname,});

  CategoryList.fromJson(dynamic json) {
    catid = json['catid'];
    catname = json['catname'];
  }
  int? catid;
  String? catname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['catid'] = catid;
    map['catname'] = catname;
    return map;
  }

}